//
//  MovieDetailsInteractor.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/23/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import Foundation

protocol MovieDetailsBusinessLogic
{
    func getMovie(request: MovieDetails.GetMovie.Request)
}

protocol MovieDetailsDataStore
{
    var movie: Movie! { get set }
}

final class MovieDetailsInteractor: MovieDetailsBusinessLogic, MovieDetailsDataStore
{
    var presenter: MovieDetailsPresentationLogic?
    
    var movie: Movie!
    
    func getMovie(request: MovieDetails.GetMovie.Request)
    {
        let response = MovieDetails.GetMovie.Response(movie: movie)
        presenter?.presentMovie(response: response)
    }
}
