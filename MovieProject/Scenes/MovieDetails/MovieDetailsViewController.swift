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

class MovieDetailsViewController: UITableViewController
{
    
    var interactor: MovieDetailsBusinessLogic?
    var router: (NSObjectProtocol & MovieDetailsRoutingLogic & MovieDetailsDataPassing)?
    var displayedMovie: MovieDetails.GetMovie.ViewModel.DisplayedMovie?
    
    
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
    
    func setBackGroundImage(viewModel: MovieDetails.GetMovie.ViewModel.DisplayedMovie) {
        self.tableView.backgroundView?.setBackgroundImage(fromUrl: viewModel.poster_path)
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

extension MovieDetailsViewController
{
    
    enum MovieSection: Int  {
        case header
        case poster
        case basicInfo
        case play
        case overview
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return MovieSection.overview.rawValue + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let displayedMovie = self.displayedMovie, let op = MovieSection(rawValue: indexPath.row) else{
            return UITableViewCell()
        }
        
        switch op {
        case .header:
            return movieHeaderCell(displayedMovie: displayedMovie)
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
}

// MARK: - UItableView Cell implementation

extension MovieDetailsViewController {
    
    struct Constant
    {
        static let movieHeaderCellReuseIdentifier = "movieHeaderCell"
        static let moviePosterCellReuseIdentifier = "moviePosterCell"
        static let movieBasicInfoCellReuseIdentifier = "movieBasicInfoCell"
        static let playMovieCellReuseIdentifier = "playMovieCell"
        static let movieDescriptionCellReuseIdentifier = "movieDescriptionCell"
    }
    
    func movieHeaderCell(displayedMovie: MovieDetails.GetMovie.ViewModel.DisplayedMovie) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.movieHeaderCellReuseIdentifier) as? MovieDetailsTableViewHeader
            else { return UITableViewCell() }
        cell.setup(withViewModel: displayedMovie)
        return cell
    }
    
    func moviePosterCell(displayedMovie: MovieDetails.GetMovie.ViewModel.DisplayedMovie) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.moviePosterCellReuseIdentifier) as? MoviePosterTableViewCell
            else { return UITableViewCell() }
        /*tableView.beginUpdates()
        // Make the frame the right size to show the thumbnail
        let cellFrame = CGRect(x: 0, y: 0, width: tableView.contentSize.width, height: 5000)
        cell.frame = cellFrame
        tableView.endUpdates()
 */
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
