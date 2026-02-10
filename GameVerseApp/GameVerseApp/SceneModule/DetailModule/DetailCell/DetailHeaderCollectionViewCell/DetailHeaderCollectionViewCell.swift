//
//  DetailHeaderCollectionViewCell.swift
//  GameVerseApp
//
//  Created by beyyzgur on 25.01.2026.
//

import UIKit
import Kingfisher

protocol DetailHeaderCollectionViewCellDelegate: AnyObject {
    func didTapFavoriteButton(model: GameDetailModel)
}

final class DetailHeaderCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var detailImageView: UIImageView!
    @IBOutlet private weak var gradientView: UIView!
    @IBOutlet private weak var gameTitleLabel: UILabel!
    @IBOutlet private weak var genreTitleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var gameInfoContainerView: UIView!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var esrbLabel: UILabel!
    @IBOutlet private weak var playtimeLabel: UILabel!
    
    weak var delegate: DetailHeaderCollectionViewCellDelegate?
    private var gameModel: GameDetailModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupGradient()
        setupGameInfoContainer()
    }
    
    public override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width,
                                height: UIView.layoutFittingExpandedSize.height)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize,
                                                                          withHorizontalFittingPriority: .required,
                                                                          verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }
    
    private func setupGameInfoContainer() {
        gameInfoContainerView.layer.cornerRadius = 20
    }
    
    private func setupGradient() {
        DispatchQueue.main.async {
        print("setaup gradient")
        let navyColorTransparant = UIColor(red: 1/255, green: 6/255, blue: 33/255, alpha: 0.1)
        let navyColor = UIColor(red: 1/255, green: 6/255, blue: 33/255, alpha: 1)
        
        let settings = GradientSettingsModel(
            startColor: navyColorTransparant,
            endColor: navyColor,
            startPoint: CGPoint(x: 0.5, y: 0.0),
            endPoint: CGPoint(x: 0.5, y: 1.0),
            locations: [0.5, 1.0]
        )
            self.gradientView.applyGradient(with: settings)
        }
    }
    
    func configure(with model: GameDetailModel) {
        self.gameModel = model
        // MARK: - görsel ve metin ayarları
        if let imageUrl = model.backgroundImage, let url = URL(string: imageUrl) {
            detailImageView.kf.setImage(with: url,
                                        placeholder: UIImage(named: "game_placeholder"),
                                        options: [.transition(.fade(0.3))])
        }
        gameTitleLabel.text = model.name
        
        if let genres = model.genres {
            let genreNames = genres.compactMap { $0.name }
            genreTitleLabel.text = genreNames.joined(separator:"\n")
        } else {
            genreTitleLabel.text = "Unknown Genre"
        }
        
        let rating = model.rating ?? 0.0
        let ratingTop = model.ratingTop ?? 5
        ratingLabel.text = "\(rating)/\(ratingTop)"
        esrbLabel.text = model.esrbRating?.name ?? "N/A"
        
        if let playtime = model.playtime {
            playtimeLabel.text = "\(playtime) H"
        } else {
            playtimeLabel.text = "unknown"
        }
        
        if let description = model.description {
            descriptionLabel.text = description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
        }
        // MARK: - favorite ayarlariii
//        let heartImage = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
//        favoriteButton.setImage(heartImage, for: .normal)
//        favoriteButton.tintColor = isFavorite ? .systemRed : .white // bi dene güzel olursa böyle devam olmazsa .white falan dene bakam
    }
}
