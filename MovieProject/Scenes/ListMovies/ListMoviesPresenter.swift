//
//  ListMoviesPresenter.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/23/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import Foundation

protocol ListMoviesPresentationLogic
{
    func presentFetchedMovies(response: ListMovies.FetchMovies.Response)
}

class ListMoviesPresenter: ListMoviesPresentationLogic
{
    
    weak var viewController: ListMoviesDisplayLogic?
    
    func presentFetchedMovies(response: ListMovies.FetchMovies.Response)
    {
        var displayedMovies: [ListMovies.FetchMovies.ViewModel.DisplayedMovie] = []
        for movie in response.movies
        {
            let displayedMovie = ListMovies.FetchMovies.ViewModel.DisplayedMovie(id: movie.id, title: movie.title, overview: movie.overview, poster_path: movie.poster_path)
            displayedMovies.append(displayedMovie)
        }
        let viewModel = ListMovies.FetchMovies.ViewModel(displayedMovies: displayedMovies)
        viewController?.displayFetchedMovies(viewModel: viewModel)
    }
}
