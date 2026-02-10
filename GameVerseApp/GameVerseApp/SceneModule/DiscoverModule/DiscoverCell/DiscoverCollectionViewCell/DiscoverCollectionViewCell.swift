//
//  DiscoverCollectionViewCell.swift
//  GameVerseApp
//
//  Created by beyyzgur on 30.01.2026.
//

import UIKit
import Kingfisher

protocol DiscoverCollectionViewCellDelegate {
}

final class DiscoverCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageView()
    }
    
    private func setupImageView() {
        imageView.layer.cornerRadius = 12
    }
    
    func configure(with model: GameModel) {
        guard let urlString = model.backgroundImage, let url = URL(string: urlString) else {
            imageView.image = UIImage(named: "game_placeholder")
            return }
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholder_image"),
            options: [
                .transition(.fade(0.3)),
                .cacheSerializer(FormatIndicatedCacheSerializer.png)
            ])
    }

}

