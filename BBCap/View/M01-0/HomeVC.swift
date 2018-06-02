//
//  HomeVC.swift
//  BBCap
//
//  Created by MBA0105 on 5/6/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import Font_Awesome_Swift

final class HomeVC: UIViewController, StoryboardIdentifiable {

    @IBOutlet private weak var menuButton: UIButton!
    @IBOutlet private weak var searchButton: UIButton!

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!

    @IBOutlet var coinButtons: [UIButton]!

    private func configView() {
        searchBar.delegate = self
        menuButton.setImage(UIImage(icon: FAType.FANavicon, size: App.Size.icon, textColor: .white), for: .normal)
        searchButton.setImage(UIImage(icon: .FASearch, size: App.Size.icon, textColor: .white), for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configTableView()
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
        searchBar.isHidden = !isHidden
        segmentedControl.isHidden = isHidden
        searchBar.becomeFirstResponder()
    }

    @IBAction private func coinButtonTouchUpInside(_ button: UIButton) {
        coinButtons.setSelected(isTrue: false)
        button.isSelected = true
    }
}

extension HomeVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as? HomeCell else { fatalError() }
        cell.data = nil
        return cell
    }
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        navigationController?.pushViewController(vc)
    }
}

extension HomeVC: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.isHidden = true
        segmentedControl.isHidden = false
        searchBar.resignFirstResponder()
    }
}
