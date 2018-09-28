//
//  RealmProvider.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/26/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmProvider: MovieDataProviderProtocol
{
    init()
    {
        //demo
    }
    
    func fetchMovies(category: Category, completionHandler completion: @escaping ([Movie]) -> Void)
    {
        
        let realm = try! Realm()
        var movies: [Movie] = []
        
        let realmMovies = realm.objects(RealmMovie.self).filter("category == %@", category.path)
        for realmMovie in realmMovies {
            movies.append(Movie(id: realmMovie.id, title: realmMovie.title, overview: realmMovie.overview, poster_path: realmMovie.poster_path, release_date: realmMovie.release_date, popularity: realmMovie.popularity, vote_average: realmMovie.vote_average, video: realmMovie.video))
        }
        
        completion(movies)
    }
    
    func fetchMovies(text: String, completionHandler completion: @escaping ([Movie]) -> Void) {
        // TO DO
    }
    
}
