//
//  FavoritesTableViewCell.swift
//  GameVerseApp
//
//  Created by beyyzgur on 2.02.2026.
//

import UIKit
import Kingfisher

class FavoritesTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var favoritesImageView: UIImageView!
    @IBOutlet weak var favoritesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favoritesImageView.image = nil
        favoritesLabel.text = nil
    }
    
    func configure(with model: GameModel) {
        favoritesLabel.text = model.name
        
        if let imageURL = model.backgroundImage, let url = URL(string: imageURL) {
            favoritesImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "game_placeholder"),
                options: [
                    .transition(.fade(0.3))
                ]
            )
        }
    }
    
    private func setupUI() {
        favoritesImageView.layer.cornerRadius = 12
        favoritesImageView.clipsToBounds = true
    }
}

// cellden viewcontrollera ulasmaya calisirken delegate kullanırım, kucukten büyüğe, içten dısa olan değişiklikleri dışarıya bildirmek için kullanılır, viewcontrollerda bisey değişirse zaten celle cellforitemat ile ulasilabileceği için delegate e gerek yok!!!!
