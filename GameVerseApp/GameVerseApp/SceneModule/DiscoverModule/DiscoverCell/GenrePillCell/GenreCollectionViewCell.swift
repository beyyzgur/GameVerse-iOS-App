//
//  GenreCollectionViewCell.swift
//  GameVerseApp
//
//  Created by beyyzgur on 22.01.2026.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var genrePillLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupGenrePillUI()
    }
    
    func setupGenrePillUI() {
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor(white: 1.0, alpha: 0.08)
    }
    
    func configureGenreLabel(text: String) {
        genrePillLabel.text = text
    }
}
