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

class ListMoviesViewController: UIViewController, ListMoviesDisplayLogic
{
    var interactor: ListMoviesBusinessLogic?
    var router: (NSObjectProtocol & ListMoviesRoutingLogic & ListMoviesDataPassing)?
    var displayedMovies: [ListMovies.FetchMovies.ViewModel.DisplayedMovie] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.5, bottom: 0.0, right: 0.0)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
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
    }
    
    private func setUpSearchBar(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setUpColletionViewColumns(){
        let width = (view.frame.width - 40) / 3
        let height = width *  1.5
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: height)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpColletionViewColumns()
        setUpSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovies()
    }

    // MARK: - Fetch movies
    
    func fetchMovies()
    {
        let request = ListMovies.FetchMovies.Request()
        interactor?.fetchMovies(request: request)
    }
    
    func fetchMovies(text: String)
    {
        let request = ListMovies.FetchMovies.Request()
        interactor?.fetchMovies(text: text, request: request)
    }
    
    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    @IBAction func didTapCategoryButton(_ sender: UIButton) {
        router?.routeToCategories()
    }
    
}

 // MARK: - ListMoviesDisplayLogic protocol implementation

extension ListMoviesViewController
{
    func displayFetchedMovies(viewModel: ListMovies.FetchMovies.ViewModel)
    {
        displayedMovies = viewModel.displayedMovies
        collectionView?.reloadData()
    }
}

// MARK: - UICollectionViewController Delegates implementation

extension ListMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    struct Constant
    {
        static let collectionItemReuseIdentifier = "MovieCollectionViewItem"
        static let collectionHeaderReuseIdentifier = "MovieCollectionViewHeader"
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let displayedMovie = displayedMovies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.collectionItemReuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        cell.setup(withViewModel: displayedMovie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Constant.collectionHeaderReuseIdentifier, for: indexPath) as! MovieCollectionViewHeader
            return reusableview
        default:  fatalError("Unexpected element kind")
        }
    }
}



// MARK: - Search Bar methods and UISearchResultsUpdating Delegate

extension ListMoviesViewController: UISearchResultsUpdating {
    
    @IBAction func toggleSearchBar(){
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchBarIsEmpty() {
            fetchMovies()
        } else {
            fetchMovies(text: searchController.searchBar.text!)
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
}


