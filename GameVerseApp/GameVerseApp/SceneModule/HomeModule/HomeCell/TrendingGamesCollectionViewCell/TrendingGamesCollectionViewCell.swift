//
//  TrendingGamesCollectionViewCell.swift
//  GameVerseApp
//
//  Created by beyyzgur on 23.01.2026.
//

import UIKit

protocol TrendingGamesCollectionViewDelegate: AnyObject {
    func didSelectGame(id: Int)
}

final class TrendingGamesCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var gameLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var trendingGames: [TrendingGamesModel] = []
    weak var delegate: TrendingGamesCollectionViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setDataSourcesAndDelegates()
        register()
        setLayout()
    }
    // trending games collection view cellin belli bir orana göre hesaplancak suan cok buyuk
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let width = layoutAttributes.frame.width
        let height = width / 1.5 // cell in en boy oranı
        
        let targetSize = CGSize(width: width,
                                height: height)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize,
                                                                          withHorizontalFittingPriority: .required,
                                                                          verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }
    
    func setDataSourcesAndDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func register() {
        let nib = UINib(nibName: "TrendingGameCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "TrendingGameCollectionViewCell")
    }
    
    private func setLayout() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 16
            layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
         //   layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    func configure(with trendingGames: [TrendingGamesModel]) {
        self.trendingGames = trendingGames
        collectionView.reloadData()
    }
}

// MARK: - extensions

extension TrendingGamesCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return trendingGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingGameCollectionViewCell", for: indexPath) as! TrendingGameCollectionViewCell
        let gameModel = trendingGames[indexPath.row]
        cell.configure(with: gameModel)
        return cell
    }
}

extension TrendingGamesCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        print("🎯 Hücre içi: Tıklanan oyun indeksi: \(indexPath.row)")
        let selectedGameId = trendingGames[indexPath.row].id
        delegate?.didSelectGame(id: selectedGameId ?? 0)
    }
}

extension TrendingGamesCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let containerHeight = collectionView.bounds.height
        let ratio: CGFloat = 0.8
        let width: CGFloat = containerHeight / ratio
        return CGSize(width: width, height: containerHeight)
    }
}
