//
//  FavoriteViewController.swift
//  PerqaraTest
//
//  Created by aditya  on 25/02/23.
//

import UIKit
import Realm

class FavoriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = [FavoriteModel]()
    
    var favoriteVM = FavouriteViewModel()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteVM.getData()
    }

    // MARK: - setupView
    
    func setupView() {

        favoriteVM.delegate = self
        
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
    }

}

// MARK: - UITableViewDataSource

extension FavoriteViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }

        let data = dataSource[indexPath.row]
        cell.configureFavoriteCell(data: data)
        cell.selectionStyle = .none

        return cell
    }

}

// MARK: - UITableViewDelegate

extension FavoriteViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = dataSource[indexPath.row]
        let vc = ProductDetailViewController()
        vc.productDetailVM.detailID = data.id
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

}


extension FavoriteViewController: FavouriteViewModelDelegate {
    
    func successGetData(data: [FavoriteModel]) {
        Helper.stopLoading()
        dataSource = data
        tableView.reloadData()
        tableView.layoutIfNeeded()
    }
}

