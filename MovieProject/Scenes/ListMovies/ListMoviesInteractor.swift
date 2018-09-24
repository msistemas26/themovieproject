//
//  ListMoviesInteractor.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/23/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import Foundation

protocol ListMoviesBusinessLogic
{
    func fetchMovies(category: MovieCategory, request: ListMovies.FetchMovies.Request)
}

protocol ListMoviesDataStore
{
   var movies: [Movie]? { get }
}

final class ListMoviesInteractor: ListMoviesBusinessLogic, ListMoviesDataStore
{
    var presenter: ListMoviesPresentationLogic?
    var moviesDataProvider: ServiceDataProvider
    
    var movies: [Movie]?
    
    init() {
        self.moviesDataProvider = ServiceDataProvider()
    }
    
    func fetchMovies(category: MovieCategory, request: ListMovies.FetchMovies.Request)
    {
        moviesDataProvider.fetchMovies(category: category) { (movies) in
            self.movies = movies
            let response = ListMovies.FetchMovies.Response(movies: movies)
            self.presenter?.presentFetchedMovies(response: response)
        }
    }
    
}
