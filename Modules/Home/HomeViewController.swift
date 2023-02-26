//
//  HomeViewController.swift
//  PerqaraTest
//
//  Created by aditya  on 25/02/23.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var homeVM = HomeViewModel()
    
    var dataSource: [ResultModel] = []
    
    var page = 1
    var perPage = 10
    var fetchingMore = false
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeVM.getData(page: page, perPage: perPage)
        setupView()
    }

    // MARK: - setupView
    
    func setupView() {
        
        Helper.defaultBlockLoading()
        
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        
        searchBar.placeholder = NSLocalizedString("Search", comment: "")
        searchBar.delegate = self
        
        homeVM.delegate = self
    }

}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }

        let data = dataSource[indexPath.row]
        cell.configureCell(data: data)
        cell.selectionStyle = .none

        return cell
    }

}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {

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

// MARK: - HomeViewModelDelegate

extension HomeViewController: HomeViewModelDelegate {
    func success(data: [ResultModel]) {
        Helper.stopLoading()
        dataSource += data
        fetchingMore = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.tableView.reloadData()
            self.tableView.layoutIfNeeded()
        }
    }

    func failedReq(message: String) {
        Helper.stopLoading()
    }

}

// MARK: - UISearchBarDelegate

extension HomeViewController : UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let viewController = SearchViewController.loadFromNib()
        navigationController?.push(viewController: viewController)

        return false
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }

    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        return true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    }
}


extension HomeViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
                loadMore()
            }
        }
    }
    
    func loadMore() {
        fetchingMore = true
        page = page + 1
        homeVM.getData(page: page, perPage: perPage)
    }

}


