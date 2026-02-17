//
//  DiscoverViewController.swift
//  GameVerseApp
//
//  Created by beyyzgur on 17.01.2026.
//

import UIKit

protocol DiscoverViewControllerInterface: AnyObject,
                                          AlertPresentable,
                                          SpinnerDisplayable{
    func showGenres(_ genres: [GenreModel])
    func showGames(_ games: [GameModel])
    func activateSearch()
}

class DiscoverViewController: UIViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    private lazy var viewmodel: DiscoverViewModelInterface = DiscoverViewModel(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSourcesAndDelegates()
        setupSearchBar()
        register()
        setupCollectionViewFlowLayout()
        
        viewmodel.fetchInitialAPIRequests()
    }
    
    private func setupDataSourcesAndDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
    }
    
    private func setupCollectionViewFlowLayout() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        }
        if let layout = categoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 16
            layout.minimumLineSpacing = 16
            layout.scrollDirection = .horizontal
            layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    private func register() {
        let discoverNib = UINib(nibName: "DiscoverCollectionViewCell", bundle: nil)
        collectionView.register(discoverNib, forCellWithReuseIdentifier: "DiscoverCollectionViewCell")
        
        let genreNib = UINib(nibName: "GenreCollectionViewCell", bundle: nil)
        categoryCollectionView.register(genreNib, forCellWithReuseIdentifier: "GenreCollectionViewCell")
    }
}

extension DiscoverViewController: DiscoverViewControllerInterface {
    func showGenres(_ genres: [GenreModel]) {
        categoryCollectionView.reloadData()
    }
    func showGames(_ games: [GameModel]) {
        collectionView.reloadData()
    }
    
    func activateSearch() {
        print("hex: activateSearch")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.searchBar.becomeFirstResponder()
        }
    }
}

extension DiscoverViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.collectionView:
            return viewmodel.games.count
        case categoryCollectionView:
            return viewmodel.genres.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.collectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCollectionViewCell", for: indexPath) as? DiscoverCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(with: viewmodel.games[indexPath.item])
            return cell
            
        case categoryCollectionView:
            guard let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionViewCell", for: indexPath) as? GenreCollectionViewCell else { return UICollectionViewCell()}
            cell.configureGenreLabel(text: viewmodel.genres[indexPath.item].name ?? "")
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension DiscoverViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case self.collectionView:
            let selectedGameId = viewmodel.games[indexPath.item].id
            viewmodel.storyboardNavigableManager.push(
                storyboardId: .detail,
                navigationController: self.navigationController,
                delegate: self,
                args: selectedGameId)
        case categoryCollectionView:
            viewmodel.didSelectGenre(at: indexPath.item)
            // basınca filtreye göre yeniden sıralancak
        default:
            break
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Sadece oyun listesi için çalışsın
        guard scrollView == self.collectionView else { return }
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        // En alta 100px kala yeni sayfayı iste
        print("hex1 scroll yapiliyor...: offsetY: \(offsetY), contentHeight: \(contentHeight), height: \(height);;; ofsetU > contentH - height - 100: \(offsetY > contentHeight - height - 100)")
        if offsetY > contentHeight - height - 100 {
            // ViewModel içindeki fetchNextPageGames() metodunu çağır
            // Not: ViewModel protokolüne (Interface) bu metodu eklemeyi unutma
            print("hex1 fetch nex games")
            viewmodel.fetchNextPageGames()
        }
    }
}

extension DiscoverViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.bounds.size.width
        let totalSpacing: CGFloat = 42
        let availableWidth = totalWidth - totalSpacing
        let itemWidth = availableWidth / 2
        let itemHeight = itemWidth * 0.8
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension DiscoverViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        viewmodel.searchGames(with: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}

extension DiscoverViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}
