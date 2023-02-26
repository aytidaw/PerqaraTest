//
//  HomeTableViewCell.swift
//  PerqaraTest
//
//  Created by aditya  on 25/02/23.
//

import UIKit
import SDWebImage

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = 4
    }
    
    func configureCell(data: ResultModel) {
        if let imageURL = URL(string: data.background_image ?? "") {
            iconImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: ""))
        }
        
        titleLabel.text = data.name
        releaseDateLabel.text = "Release date \(data.released ?? "")"
        ratingLabel.text = "\(data.rating ?? 0)"
        ratingImage.image = UIImage(named: "icn_star")
    }
    
    func configureFavoriteCell(data: FavoriteModel) {
        if let imageURL = URL(string: data.imageURL) {
            iconImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: ""))
        }
        
        titleLabel.text = data.title
        releaseDateLabel.text = "Release date \(data.released)"
        ratingLabel.text = "\(data.rating)"
        ratingImage.image = UIImage(named: "icn_star")
    }
    
    func configureSearchCell(data: ResultSearchModel) {
        if let imageURL = URL(string: data.background_image ?? "") {
            iconImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: ""))
        }
        
        titleLabel.text = data.name
        releaseDateLabel.text = "Release date \(String(describing: data.released))"
        ratingLabel.text = "\(data.rating ?? 0)"
        ratingImage.image = UIImage(named: "icn_star")
    }
}
