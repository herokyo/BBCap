//
//  HomeVC.swift
//  BBCap
//
//  Created by MBA0105 on 5/6/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import Font_Awesome_Swift

class HomeVC: UIViewController, StoryboardIdentifiable {

    @IBOutlet private weak var menuButton: UIButton!
    @IBOutlet private weak var searchButton: UIButton!

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.setImage(UIImage(icon: FAType.FANavicon, size: App.Size.icon, textColor: .white), for: .normal)
        searchButton.setImage(UIImage(icon: .FASearch, size: App.Size.icon, textColor: .white), for: .normal)
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
    }
}

extension HomeVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") else { fatalError() }
        return cell
    }
}

extension HomeVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc)
    }
}
