//
//  HomeViewController.swift
//  GameVerseApp
//
//  Created by beyyzgur on 16.01.2026.
//

import UIKit

protocol HomeViewControllerInterface: AnyObject,
                                      AlertPresentable {
    func showTrendingGames(_ games: [TrendingGamesModel])
    func showTopRatedGames(_ games: [GameModel])
}

final class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private lazy var viewmodel: HomeViewModelInterface = HomeViewModel(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomFlowLayout() // çünkü layout en basta ayarlanır => layout => cell ölçümü => auto-layout
        setupDataSourcesAndDelegates()
        registerCells()
        
        viewmodel.fetchTrendingGames()
        viewmodel.fetchTopRatedGames()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setupDataSourcesAndDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func registerCells() {
        let headerNib = UINib(nibName: "HeaderCollectionViewCell", bundle: nil)
        collectionView.register(headerNib, forCellWithReuseIdentifier: "HeaderCollectionViewCell")
        
        let trendingGamesNib = UINib(nibName: "TrendingGamesCollectionViewCell", bundle: nil)
        collectionView.register(trendingGamesNib, forCellWithReuseIdentifier: "TrendingGamesCollectionViewCell")
        
        let topRatedGamesNib = UINib(nibName: "TopRatedCollectionViewCell", bundle: nil)
        collectionView.register(topRatedGamesNib, forCellWithReuseIdentifier: "TopRatedCollectionViewCell")
    }
}
// register edicem, collection view için data source ve delegate metotlarını eklicem, data source metotlarında section kullanmam lazım, home da collection viewa flow layout yazmam lazım , home a tek columnlu single column flow layout yazmam lazım UICollectionViewFlowLayout , dataları set ettikten sonra reload data demen lazım
// MARK: - extensions
extension HomeViewController: HomeViewControllerInterface {
    func showTrendingGames(_ games: [TrendingGamesModel]) {
        collectionView.reloadData()
    }
    
    func showTopRatedGames(_ games: [GameModel]) {
        collectionView.reloadData()
    }
}
extension HomeViewController: DynamicFlowLayoutCustomizable {
    typealias CustomLayout = SingleColumnDynamicHeightFlowLayout
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HomeSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let section = HomeSection(rawValue: section) else { return 0 }
        
        switch section {
        case .header:
            return 1
        case .trendingGames:
            return 1 // yatayda kayan tek 1 cell
        case .topRatedGames:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = HomeSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
        switch section {
        case .header:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCollectionViewCell", for: indexPath) as! HeaderCollectionViewCell
            cell.delegate = self
            return cell
        case .trendingGames:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingGamesCollectionViewCell", for: indexPath) as! TrendingGamesCollectionViewCell
            cell.configure(with: viewmodel.trendingGames)
            cell.delegate = self
            return cell
        case .topRatedGames:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedCollectionViewCell", for: indexPath) as? TopRatedCollectionViewCell else { return UICollectionViewCell() }
            cell.configureL(with: viewmodel.topRatedGames)
            cell.delegate = self
            return cell
        }
    }
}

extension HomeViewController: TrendingGamesCollectionViewDelegate,
                              TopRatedCollectionViewDelegate {
    func didSelectGame(id: Int) {
        print("🏠 HomeViewController: Hücreden haber geldi! Oyun ID: \(id)")
        viewmodel.storyboardNavigableManager.push(
            storyboardId: .detail,
            navigationController: self.navigationController,
            args: id)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let section = HomeSection(rawValue: section) else { return .zero }
        
        switch section {
        case .header:
            return UIEdgeInsets(
                top: 8,
                left: 0,
                bottom: 8,
                right: 0
            )
        case .trendingGames:
            return UIEdgeInsets(
                top: 16,
                left: 16,
                bottom: 0,
                right: 16
            )
        case .topRatedGames:
            return UIEdgeInsets(
                top: 32,
                left: 16,
                bottom: 0,
                right: 16)
        }
    }
}
extension HomeViewController: HeaderCollectionViewCellDelegate {
    func didTriggerSearchButton() {
        print("hex: didTriggerSearchButton")
        guard let tabBarController = self.tabBarController else { return } // ???
        tabBarController.selectedIndex = 1
        
        if let navVC = tabBarController.viewControllers?[1] as? UINavigationController,
           let discoverVC = navVC.viewControllers.first as? DiscoverViewController {
            discoverVC.activateSearch()
        }
    }
}
