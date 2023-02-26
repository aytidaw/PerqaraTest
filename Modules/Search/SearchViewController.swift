//
//  ProductDetailViewController.swift
//  PerqaraTest
//
//  Created by aditya  on 25/02/23.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    var dataSource: [ResultSearchModel] = []
    
    var searchVM = SearchViewModel()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    // MARK: - setupView
    
    func setupView() {
        searchVM.delegate = self
        
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        
        searchBar.delegate = self
    }
    
    // MARK: - Action
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.pop()
    }
    
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        let data = dataSource[indexPath.row]
        cell.configureSearchCell(data: data)
        cell.selectionStyle = .none
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
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

extension SearchViewController: SearchViewModelDelegate {
    func success(data: [ResultSearchModel]) {
        Helper.stopLoading()
        dataSource = data
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.tableView.reloadData()
            self.tableView.layoutIfNeeded()
        }
    }
    
    func failedReq(message: String) {
        Helper.stopLoading()
    }
    
}

//// MARK: - UISearchBarDelegate
extension SearchViewController : UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        Helper.defaultBlockLoading()
        searchVM.getData(query: searchText)
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
}
