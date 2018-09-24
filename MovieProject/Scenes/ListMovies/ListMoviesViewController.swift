//
//  ListMoviesViewController.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/23/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import UIKit

protocol ListMoviesDisplayLogic: class
{
    func displayFetchedMovies(viewModel: ListMovies.FetchMovies.ViewModel)
}

class ListMoviesViewController: UICollectionViewController
{
    
    var interactor: ListMoviesBusinessLogic?
    var router: (NSObjectProtocol & ListMoviesRoutingLogic & ListMoviesDataPassing)?
    var displayedMovies: [ListMovies.FetchMovies.ViewModel.DisplayedMovie] = []
    
    var category: Category?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = ListMoviesInteractor()
        let presenter = ListMoviesPresenter()
        let router = ListMoviesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        category = nil
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchMovies()
    }

    // MARK: - Fetch movies
    
    func fetchMovies()
    {
        let request = ListMovies.FetchMovies.Request()
        interactor?.fetchMovies(category: .popular, request: request)
    }
    
    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            print(selector)
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
}

 // MARK: - ListMoviesDisplayLogic protocol implementation

extension ListMoviesViewController: ListMoviesDisplayLogic
{
    func displayFetchedMovies(viewModel: ListMovies.FetchMovies.ViewModel)
    {
        displayedMovies = viewModel.displayedMovies
        collectionView?.reloadData()
    }
}

// MARK: - UICollectionViewController Delegates implementation

extension ListMoviesViewController
{
    struct Constant
    {
        static let collectionItemReuseIdentifier = "MovieCollectionViewItem"
        static let collectionHeaderReuseIdentifier = "MovieCollectionViewHeader"
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedMovies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let displayedMovie = displayedMovies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.collectionItemReuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        cell.setup(withViewModel: displayedMovie)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Constant.collectionHeaderReuseIdentifier, for: indexPath) as! MovieCollectionViewHeader
            return reusableview
        default:  fatalError("Unexpected element kind")
        }
    }
}


