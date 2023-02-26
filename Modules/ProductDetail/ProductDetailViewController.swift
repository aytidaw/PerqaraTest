//
//  ProductDetailViewController.swift
//  PerqaraTest
//
//  Created by aditya  on 25/02/23.
//

import UIKit
import RealmSwift

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var developerLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var totalPlayed: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var statusLoved: Bool = false
    var dataSource: ProductModel?
    
    var productDetailVM = ProductDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        Helper.defaultBlockLoading()
        productDetailVM.getData()
        productDetailVM.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        productDetailVM.getDataFromRealm()
    }
    
    func setupView() {
        if let validData = dataSource {
            if let imageURL = URL(string: validData.background_image ?? "") {
                iconImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: ""))
            }
            developerLabel.text = validData.publishers?.first?.name
            
            titleLabel.text = validData.name
            releaseDate.text = "Release Date \(validData.released ?? "")"
            totalPlayed.text = "\(validData.playtime ?? 0) played"
            descriptionLabel.text = validData.description ?? ""
        }
        
        if let _ = RealmManager.shared.getFavoriteData().first(where: {$0.id == dataSource?.id }) {
            favoriteButton.setImage(UIImage(named: "icn_love_selected"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "icn_love_normal"), for: .normal)
        }
        
    }

    @IBAction func backTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func favoriteTapped(_ sender: Any) {
        Helper.defaultBlockLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            Helper.stopLoading()
            if let currentLove = RealmManager.shared.getFavoriteData().first(where: {$0.id == self.dataSource?.id }) {
                self.favoriteButton.setImage(UIImage(named: "icn_love_normal"), for: .normal)
                RealmManager.shared.delete(currentLove)
            } else {
                self.favoriteButton.setImage(UIImage(named: "icn_love_selected"), for: .normal)
                RealmManager.shared.createFavoriteData(
                    id: self.dataSource?.id ?? 0,
                    title: self.dataSource?.name ?? "",
                    imageUrl: self.dataSource?.background_image ?? "",
                    released: self.dataSource?.released ?? "",
                    rating: self.dataSource?.rating ?? 0.0 ,
                    isRating: true)
            }
        }
    }
    
}

extension ProductDetailViewController: ProductDetailViewModelDelegate {
    func success(data: ProductModel) {
        Helper.stopLoading()
        dataSource = data
        setupView()
    }
    
    func failedReq(message: String) {
        Helper.stopLoading()
    }

}
