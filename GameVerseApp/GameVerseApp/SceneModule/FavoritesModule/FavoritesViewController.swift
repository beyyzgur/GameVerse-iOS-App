//
//  FavoritesViewController.swift
//  GameVerseApp
//
//  Created by beyyzgur on 17.01.2026.
//

import UIKit

protocol FavoritesViewControllerInterface: AnyObject {
    func showFavorites(_ game: [GameModel])
}
// favoriteste bişi yokkken no favorites yet desin.
class FavoritesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    private lazy var viewmodel: FavoritesViewModelInterface = FavoritesViewModel(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewDataSourceAndDelegates()
        register()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewmodel.fetchFavorites()
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        let font = UIFont(name: "HoeflerText-Regular", size: 18)
        
        navigationController?.navigationBar.topItem?.title = "Wishlist"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.textColorWhite,
                                                                   .font: font]
    }
    
    func setTableViewDataSourceAndDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func register() {
        let nib = UINib(nibName: "FavoritesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "FavoritesTableViewCell")
    }
    
    private func setEmptyViewHidden(isHidden: Bool) {
        emptyView.isHidden = isHidden
    }
    
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        let favoriteGames = viewmodel.favoriteGames
        return favoriteGames.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell") as? FavoritesTableViewCell,
              let game = viewmodel.getGame(at: indexPath.row)
        else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configure(with: game)
        return cell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let gameId = viewmodel.favoriteGames[indexPath.row].id {
                FavoritesManager.shared.removeFavorite(gameId: gameId)
                viewmodel.fetchFavorites()
            }
        }
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let selectedId = viewmodel.favoriteGames[indexPath.row].id
        viewmodel.storyboardNavigableManager.push(
            storyboardId: .detail,
            navigationController: self.navigationController,
            delegate: self,
            args: selectedId
        )
    }
}

// MARK: - interfaces & delegates

extension FavoritesViewController: FavoritesViewControllerInterface {
    func showFavorites(_ game: [GameModel]) {
        DispatchQueue.main.async {
            if game.isEmpty {
                self.setEmptyViewHidden(isHidden: false)
            } else {
                self.setEmptyViewHidden(isHidden: true)
            }
            self.tableView.reloadData()
        }
    }
}
