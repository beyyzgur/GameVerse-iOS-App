//
//  TopRatedCollectionViewCell.swift
//  GameVerseApp
//
//  Created by beyyzgur on 7.02.2026.
//

import UIKit

protocol TopRatedCollectionViewDelegate: AnyObject {
    func didSelectGame(id: Int)
}

class TopRatedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var topRatedLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    private var topRatedGames: [GameModel] = []
    weak var delegate: TopRatedCollectionViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setDataSourcesAndDelegates()
        register()
        setLayout()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let width = layoutAttributes.size.width
        let height = width / 1.2
        
        let targetSize = CGSize(width: width, height: height)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .fittingSizeLevel,
            verticalFittingPriority: .fittingSizeLevel)
        
        return layoutAttributes
    }
    
    func configureL(with topRatedGames: [GameModel]) {
        self.topRatedGames = topRatedGames
        collectionView.reloadData()
    }
    
    private func setDataSourcesAndDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func register() {
        let nib = UINib(nibName: "TopRatedGameCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "TopRatedGameCollectionViewCell")
    }
    
    private func setLayout() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 16
            layout.minimumInteritemSpacing = 16
            layout.scrollDirection = .horizontal
            layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
    }
    
}

extension TopRatedCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return topRatedGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedGameCollectionViewCell", for: indexPath) as? TopRatedGameCollectionViewCell else { return UICollectionViewCell() }
        
        let topRatedGames = topRatedGames[indexPath.item]
        cell.configure(with: topRatedGames)
        return cell
    }
}

extension TopRatedCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let selectedId = topRatedGames[indexPath.item].id
        delegate?.didSelectGame(id: selectedId ?? 0)
    }
}

extension TopRatedCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let containerHeight = collectionView.bounds.height
        let ratio: CGFloat = 0.78
        let width: CGFloat = containerHeight / ratio
        return CGSize(width: width, height: containerHeight)
    }
}
