//
//  TheMovieService.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/23/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import Foundation
import RealmSwift

protocol MovieDataProviderProtocol
{
    func fetchMovies(category: Category, completionHandler completion: @escaping ([Movie]) -> Void)
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
    
    func fetchMovies(category: Category?, completionHandler completion: @escaping ([Movie]) -> Void)
    {
        movieDataProvide.fetchMovies(category: category ?? defaulCategory()) { result in
            completion(result)
        }
    }
    
    func fetchMovies(text: String, completionHandler completion: @escaping ([Movie]) -> Void)
    {
        let realm = try! Realm()
        var movies: [Movie] = []
        
        let realmMovies = realm.objects(RealmMovie.self).filter("title CONTAINS[c] %@", text)
        for realmMovie in realmMovies {
            movies.append(Movie(id: realmMovie.id, title: realmMovie.title, overview: realmMovie.overview, poster_path: realmMovie.poster_path, release_date: realmMovie.release_date, popularity: realmMovie.popularity, vote_average: realmMovie.vote_average, video: realmMovie.video))
        }
        
        completion(movies)
    }
    
    func fetchCategories(completionHandler completion: @escaping ([Category]) -> Void) {
        var categories:[Category] = []
        categories.append(Category(id: 1, name: "Popular", path: "/movie/popular"))
        categories.append(Category(id: 2, name: "Top Rated", path: "/movie/top_rated"))
        categories.append(Category(id: 3, name: "Upcoming", path: "/movie/upcoming"))
        completion(categories)
    }
    
    func defaulCategory()-> Category {
        return (Category(id: 1, name: "Popular", path: "/movie/popular"))
    }
}
