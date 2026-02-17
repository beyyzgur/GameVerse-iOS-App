//
//  DetailViewController.swift
//  GameVerseApp
//
//  Created by beyyzgur on 25.01.2026.
//

import UIKit

protocol DetailViewControllerInterface: AnyObject,
                                        AlertPresentable,
                                        SpinnerDisplayable {
    func showGameDetails(_ gameDetails: [GameDetailModel])
}

class DetailViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var gameId: Int?
    
    private lazy var viewmodel: DetailViewModelInterface = DetailViewModel(view: self, gameId: gameId ?? 0) // ???
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewmodel.fetchInitialAPIRequests()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    @objc private func favoriteBarButtonTriggered() {
        guard let details = viewmodel.gameDetails.first else { return }
        viewmodel.toggleFavorite(model: details)
        configureNavigationBar()
    }
    
    private func setupUI() {
        collectionView.contentInsetAdjustmentBehavior = .never
        setDataSourcesAndDelegates()
        registerCells()
        setCustomFlowLayout(
            contentInset: UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: 92,
                right: 0))
    }
    
    private func configureNavigationBar() {
        let font = UIFont(name: "HoeflerText-Regular", size: 18)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white,
                                          .font: font as Any]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        let isFavorite = viewmodel.checkIsFavorite(gameId ?? 0)
        let heartImage = UIImage(systemName: isFavorite ? "heart.fill" : "heart")
        
        let favoriteBarButtonItem = UIBarButtonItem(image: heartImage,
                                                    style: .plain,
                                                    target: self,
                                                    action: #selector(favoriteBarButtonTriggered))
        if isFavorite {
            favoriteBarButtonItem.tintColor = .red
        }
        navigationItem.rightBarButtonItem = favoriteBarButtonItem
    }
    
    func setDataSourcesAndDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func registerCells() {
        let detailHeaderNib = UINib(nibName: "DetailHeaderCollectionViewCell", bundle: nil)
        collectionView.register(detailHeaderNib, forCellWithReuseIdentifier: "DetailHeaderCollectionViewCell")
    }
    
}

// MARK: - extensions
extension DetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return DetailSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return DetailSection.allCases.count // ???
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = DetailSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
        
        switch section {
        case .detailHeader:
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailHeaderCollectionViewCell", for: indexPath)
                    as? DetailHeaderCollectionViewCell else { return UICollectionViewCell() }
            if let details = viewmodel.gameDetails.first {
                cell.delegate = self
                cell.configure(with: details)
            }
            return cell
        }
    }
}

// MARK: - interfaces & delegates
extension DetailViewController: DetailViewControllerInterface {
    func showGameDetails(_ gameDetails: [GameDetailModel]) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.configureNavigationBar()
        }
    }
}

extension DetailViewController: DynamicFlowLayoutCustomizable {
    typealias CustomLayout = SingleColumnDynamicHeightFlowLayout
}

extension DetailViewController: DetailHeaderCollectionViewCellDelegate {
    func didTapFavoriteButton(model: GameDetailModel) {
        viewmodel.toggleFavorite(model: model)
    }
}

extension DetailViewController: UICollectionViewDelegate {
    
}
