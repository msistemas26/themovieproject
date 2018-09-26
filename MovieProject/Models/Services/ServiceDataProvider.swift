//
//  TheMovieService.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/23/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import Foundation

protocol MovieDataProviderProtocol
{
    func fetchMovies(category: MovieCategory, completionHandler completion: @escaping ([Movie]) -> Void)
    func fetchMovies(text: String, completionHandler completion: @escaping ([Movie]) -> Void)
}

/// Enum that represents service errors
enum ServiceError: Error
{
    case notConnectivity
    case serviceError(String)
    case unknown
}

class ServiceDataProvider
{
    
    var movieDataProvide: MovieDataProviderProtocol
    
    init()
    {
        self.movieDataProvide = CheckInternet.Connection() ? TheMovieApi() : RealmProvider()
    }
    
    func fetchMovies(category: MovieCategory, completionHandler completion: @escaping ([Movie]) -> Void)
    {
        movieDataProvide.fetchMovies(category: category) { result in
            completion(result)
        }
    }
    
    func fetchMovies(text: String, completionHandler completion: @escaping ([Movie]) -> Void)
    {
        movieDataProvide.fetchMovies(text: text) { result in
            completion(result)
        }
    }
    
    func fetchCategories(completionHandler completion: @escaping ([Category]) -> Void) {
        var categories:[Category] = []
        categories.append(Category(id: 1, name: "Popular"))
        categories.append(Category(id: 2, name: "Top Rated"))
        categories.append(Category(id: 3, name: "Upcoming"))
        completion(categories)
    }

}
