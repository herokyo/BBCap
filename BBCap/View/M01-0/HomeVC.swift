//
//  HomeVC.swift
//  BBCap
//
//  Created by MBA0105 on 5/6/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import Font_Awesome_Swift
import Async

final class HomeVC: UIViewController, StoryboardIdentifiable {

    @IBOutlet private weak var menuButton: UIButton!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!

    @IBOutlet var coinButtons: [UIButton]!
    @IBOutlet var timeButtons: [UIButton]!

    var sourceTickets: [Ticket] = [] {
        didSet {
            tickets = sourceTickets
        }
    }

    var tickets: [Ticket] = [] {
        didSet {
            Async.main {
                (self.tickets as [VirtualMoneyProtocol]).getUsdOverEth()
                self.tableView.reloadData()
            }
        }
    }

    var globalInfo: GlobalInfo! {
        didSet {
            Async.main {
                let valueString = "$\(self.globalInfo.totalMarketCapUsd.formatDecimal(minimum: 0, maximum: 8))"
                let percentString = "(\(self.globalInfo.percentString)%)"
                let att = NSMutableAttributedString(attributedString: NSAttributedString(string: "\(valueString) \(percentString)",
                    attributes: TextAttributes.normal))
                self.titleLabel.attributedText = att.applying(attributes: TextAttributes.green, toRangesMatching: percentString)
            }
        }
    }

    private func configView() {
        searchBar.delegate = self
        coinButtons.first?.isSelected = true
        timeButtons.first?.isSelected = true
        menuButton.setImage(UIImage(icon: FAType.FANavicon, size: App.Size.icon, textColor: .white), for: .normal)
        searchButton.setImage(UIImage(icon: .FASearch, size: App.Size.icon, textColor: .white), for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configTableView()
        getGlobalInfo()
        getTickets()
    }

    private func getGlobalInfo() {
        Api.CoinmarketCap.getGlobal { [weak self] (result) in
            switch result {
            case .success(let global):
                self?.globalInfo = global
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func getTickets() {
        Api.CoinmarketCap.getTickets { [weak self] (result) in
            switch result {
            case .success(let tickets):
                self?.sourceTickets = tickets
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func menuButtonTouchUpInside(_ sender: UIButton?) {
        SideMenuController.shared.showLeftViewAnimated()
    }

    @IBAction private func searchButtonTouchUpInside(_ sender: Any?) {
        let isHidden = searchBar.isHidden
        searchBar.text = ""
        searchBar.isHidden = !isHidden
        segmentedControl.isHidden = isHidden
        searchBar.becomeFirstResponder()
    }

    @IBAction private func coinButtonTouchUpInside(_ button: UIButton) {
        coinButtons.setSelected(isTrue: false)
        button.isSelected = true
    }

    @IBAction private func timeButtonTouchUpInside(_ button: UIButton) {
        timeButtons.setSelected(isTrue: false)
        button.isSelected = true
    }
}

extension HomeVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as? HomeCell, let ticket = tickets[safe: indexPath.row] else { fatalError() }
        cell.data = HomeCell.Data(ticket: ticket, index: indexPath.row + 1)
        return cell
    }
}

extension HomeVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        let data = HomeCell.Data(ticket: tickets[indexPath.row], index: indexPath.row + 1)
        vc.viewModel = DetailViewModel(data: data)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc)
    }
}

extension HomeVC: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, text.isNotEmpty else { return }
        tickets = sourceTickets.filter { $0.name.or("").lowercased().contains(text.lowercased()) }
        searchBar.isHidden = true
        segmentedControl.isHidden = false
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tickets = sourceTickets
        searchBar.isHidden = true
        segmentedControl.isHidden = false
        searchBar.resignFirstResponder()
    }
}

extension HomeVC: UIScrollViewDelegate {

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.isHidden = true
        segmentedControl.isHidden = false
        searchBar.resignFirstResponder()
    }
}
