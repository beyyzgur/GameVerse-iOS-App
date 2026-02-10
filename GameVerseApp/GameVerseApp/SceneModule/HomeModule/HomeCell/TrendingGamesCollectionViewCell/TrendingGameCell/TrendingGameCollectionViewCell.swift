//
//  TrendingGameCollectionViewCell.swift
//  GameVerseApp
//
//  Created by beyyzgur on 23.01.2026.
//

import UIKit
import Kingfisher

class TrendingGameCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    func setupUI() {
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemBackground
    }
    
    func configure(with model: TrendingGamesModel) { // görseli indirip eşitleyelim
        guard let urlString = model.backgroundImage, let url = URL(string: urlString) else {
            imageView.image = UIImage(named: "game_placeholder")
            return
        }
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholder_image"),
            options: [
                .transition(.fade(0.3)),
                .cacheSerializer(FormatIndicatedCacheSerializer.png)
                //.processor(DownsamplingImageProcessor(size: imageView.bounds.size))
            ])
    }
}
