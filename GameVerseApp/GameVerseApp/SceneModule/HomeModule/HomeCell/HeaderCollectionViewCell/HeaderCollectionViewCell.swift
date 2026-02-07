//
//  HeaderCollectionViewCell.swift
//  GameVerseApp
//
//  Created by beyyzgur on 19.01.2026.
//

import UIKit

protocol HeaderCollectionViewCellDelegate: AnyObject {
    func didTriggerSearchButton()
}

final class HeaderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    
    weak var delegate: HeaderCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureSearchButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setImageView()
    }
    
    public override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width,
                                height: UIView.layoutFittingExpandedSize.height)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize,
                                                                          withHorizontalFittingPriority: .required,
                                                                          verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }
    
    @IBAction func searchButtonTriggered(_ sender: UIButton) {
        print("hex: searchButtonTriggered ")
        delegate?.didTriggerSearchButton()
    }
    
    func setImageView() {
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true
    }
    
    func configureSearchButton() {
        var config = UIButton.Configuration.plain()
        config.background.backgroundColor = UIColor(white: 1.0, alpha: 0.08)
        config.background.cornerRadius = 27 // 54 / 2
        config.background.strokeWidth = 0
        
        config.image = UIImage(systemName: "magnifyingglass")
        config.baseForegroundColor = .white
        searchButton.configuration = config
    }
    
    
    //bunu uiview + extensiona makerounded ismiyle tası, extension ile kullanilabilir hale getir
    
}
