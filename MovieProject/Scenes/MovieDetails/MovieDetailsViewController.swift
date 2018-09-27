//
//  MovieDetailsViewController.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/23/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import UIKit

protocol MovieDetailsDisplayLogic: class
{
    func displayMovieDetails(viewModel: MovieDetails.GetMovie.ViewModel)
}

class MovieDetailsViewController: UIViewController
{
    
    var interactor: MovieDetailsBusinessLogic?
    var router: (NSObjectProtocol & MovieDetailsRoutingLogic & MovieDetailsDataPassing)?
    var displayedMovie: MovieDetails.GetMovie.ViewModel.DisplayedMovie?
    
    @IBOutlet weak var tableView: UITableView!
    
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
        let interactor = MovieDetailsInteractor()
        let presenter = MovieDetailsPresenter()
        let router = MovieDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        getMovie()
    }
    
    func getMovie()
    {
        let request = MovieDetails.GetMovie.Request()
        interactor?.getMovie(request: request)
    }
    
    @IBAction func didTapClose(_ sender: UIButton) {
         router?.routeBack()
    }
    
    @IBAction func didTapPlay(_ sender: UIButton) {
        guard let url = URL(string: "https://video.feoh4-2.fna.fbcdn.net/v/t42.9040-2/42499987_304685890325270_8973540489395437568_n.mp4?_nc_cat=1&efg=eyJ2ZW5jb2RlX3RhZyI6InN2ZV9zZCJ9&oh=4a9afbf80e56ea52e65d304decd50a5c&oe=5BAD1ECD") else {
            return
        }
        router?.routeToPlayMovie(withUrl: url)
    }
    
    func setBackGroundImage(viewModel: MovieDetails.GetMovie.ViewModel.DisplayedMovie) {
        self.view.setBackgroundImage(fromUrl: viewModel.poster_path)
    }
    
}

extension  MovieDetailsViewController: MovieDetailsDisplayLogic
{
    
    func displayMovieDetails(viewModel: MovieDetails.GetMovie.ViewModel)
    {
        displayedMovie = viewModel.displayedMovie
        setBackGroundImage(viewModel: displayedMovie!)
        tableView.reloadData()
    }
}

// MARK: - UUtableView Delegates implementation

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource
{
    
    enum MovieSection: Int  {
        case poster
        case basicInfo
        case play
        case overview
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return MovieSection.overview.rawValue + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let _ = self.displayedMovie, let op = MovieSection(rawValue: indexPath.row) else{
            return 0.0
        }
        
        switch op {
        case .poster:
            return 300.0
        case .basicInfo:
            return 70.0
        case .play:
            return 50.0
        case .overview:
            return 250.0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let displayedMovie = self.displayedMovie, let op = MovieSection(rawValue: indexPath.row) else{
            return UITableViewCell()
        }
        
        switch op {
        case .poster:
            return moviePosterCell(displayedMovie: displayedMovie)
        case .basicInfo:
            return basicInfoCell(displayedMovie: displayedMovie)
        case .play:
            return playMovieCell(displayedMovie: displayedMovie)
        case .overview:
            return movieDescriptionCell(displayedMovie: displayedMovie)
        }
    }

    struct Constant
    {
        static let moviePosterCellReuseIdentifier = "moviePosterCell"
        static let movieBasicInfoCellReuseIdentifier = "movieBasicInfoCell"
        static let playMovieCellReuseIdentifier = "playMovieCell"
        static let movieDescriptionCellReuseIdentifier = "movieDescriptionCell"
    }
    
    func moviePosterCell(displayedMovie: MovieDetails.GetMovie.ViewModel.DisplayedMovie) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.moviePosterCellReuseIdentifier) as? MoviePosterTableViewCell
            else { return UITableViewCell() }
  
        cell.setup(withViewModel: displayedMovie)
        return cell
    }
    
    func basicInfoCell(displayedMovie: MovieDetails.GetMovie.ViewModel.DisplayedMovie) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.movieBasicInfoCellReuseIdentifier) as? MovieBasicInfoTableViewCell
            else { return UITableViewCell() }
        cell.setup(withViewModel: displayedMovie)
        return cell
    }
    
    func playMovieCell(displayedMovie: MovieDetails.GetMovie.ViewModel.DisplayedMovie) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.playMovieCellReuseIdentifier) as? PlayMovieTableViewCell
            else { return UITableViewCell() }
        cell.setup(withViewModel: displayedMovie)
        return cell
    }
    
    func movieDescriptionCell(displayedMovie: MovieDetails.GetMovie.ViewModel.DisplayedMovie) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.movieDescriptionCellReuseIdentifier) as? MovieDescriptionTableViewCell
            else { return UITableViewCell() }
        cell.setup(withViewModel: displayedMovie)
        return cell
    }
}
