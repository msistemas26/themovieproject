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
    func fetchMovies(request: ListMovies.FetchMovies.Request)
    func fetchMovies(text: String, request: ListMovies.FetchMovies.Request)
}

protocol ListMoviesDataStore
{
   var movies: [Movie]? { get }
   var category: Category! { get set }
}

final class ListMoviesInteractor: ListMoviesBusinessLogic, ListMoviesDataStore
{

    var presenter: ListMoviesPresentationLogic?
    var moviesDataProvider: ServiceDataProvider
    
    var movies: [Movie]?
    var category: Category!
    
    init() {
        self.moviesDataProvider = ServiceDataProvider()
    }
    
    func fetchMovies(request: ListMovies.FetchMovies.Request)
    {
        moviesDataProvider.fetchMovies(category: category) { (movies) in
            self.movies = movies
            let response = ListMovies.FetchMovies.Response(movies: movies)
            self.presenter?.presentFetchedMovies(response: response)
        }
    }
    
    func fetchMovies(text: String, request: ListMovies.FetchMovies.Request)
    {
        moviesDataProvider.fetchMovies(text: text) { (movies) in
            self.movies = movies
            let response = ListMovies.FetchMovies.Response(movies: movies)
            self.presenter?.presentFetchedMovies(response: response)
        }
    }
    
}
