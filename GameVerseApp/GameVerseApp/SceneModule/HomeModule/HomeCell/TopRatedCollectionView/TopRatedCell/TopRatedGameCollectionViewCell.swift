//
//  TopRatedGameCollectionViewCell.swift
//  GameVerseApp
//
//  Created by beyyzgur on 7.02.2026.
//

import UIKit
import Kingfisher

class TopRatedGameCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var topRatedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        topRatedImageView.kf.cancelDownloadTask()
        topRatedImageView.image = nil
    }
    
    private func setupUI() {
        topRatedImageView.layer.cornerRadius = 12
        topRatedImageView.clipsToBounds = true
    }
    
    func configure(with model: GameModel) {
        guard let urlString = model.backgroundImage, let url = URL(string: urlString) else {
            topRatedImageView.image = UIImage(named: "game_placeholder")
            return
        }
        topRatedImageView.kf.indicatorType = .activity
        topRatedImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholder_image"),
            options: [
                .transition(.fade(0.3)),
                .cacheSerializer(FormatIndicatedCacheSerializer.png)
            ]
        )
    }
}
