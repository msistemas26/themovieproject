//
//  MovieDetailsPresenter.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/23/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import Foundation

protocol MovieDetailsPresentationLogic
{
    func presentMovie(response: MovieDetails.GetMovie.Response)
}

class MovieDetailsPresenter: MovieDetailsPresentationLogic
{

    weak var viewController: MovieDetailsDisplayLogic?
    
    func presentMovie(response: MovieDetails.GetMovie.Response) {
        let movie = response.movie
        let displayedMovie = MovieDetails.GetMovie.ViewModel.DisplayedMovie(id: movie.id, title: movie.title, overview: movie.overview, poster_path: movie.poster_path, release_date: movie.release_date, popularity: movie.popularity, vote_average: movie.vote_average, video: movie.video)
        let viewModel = MovieDetails.GetMovie.ViewModel(displayedMovie: displayedMovie)
        viewController?.displayMovieDetails(viewModel: viewModel)
    }
}
