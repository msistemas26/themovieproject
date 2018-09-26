//
//  TheMovieApi.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/23/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

enum ServiceResult<U>
{
    case Success(result: U)
    case Failure(error: ServiceError)
}

struct Contants
{
    static let api_Key = "d73db914dac006d1c918264e2b2e6517"
    static let home_path = "https://api.themoviedb.org/3"
}

enum MovieCategory: String
{
    case popular = "/movie/popular"
    case topRated = "/movie/top_rated"
    case upcoming = "/movie/upcoming"
}

enum ImagePath: String {
    case poster_path_original = "https://image.tmdb.org/t/p/original"
}

final class TheMovieApi: MovieDataProviderProtocol
{
    
    init()
    {
        //demo
    }
    
    func fetchMovies(category: MovieCategory, completionHandler completion: @escaping ([Movie]) -> Void)
    {
        let urlString = Contants.home_path + category.rawValue + "?api_key=" + Contants.api_Key
        
        Alamofire
            .request(urlString)
            .responseJSON { response in
                print(response)
                
                guard let result = response.data else {
                    completion([])
                    return
                }
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                    
                var movies: MovieList
                movies = try! decoder.decode(MovieList.self, from: result)
                self.saveMovieIntoRealm(movies: movies.results, category: category)
                completion(movies.results)
        }
    }
    
    func fetchMovie(id: String, completionHandler: @escaping (Movie?, ServiceError?) -> Void) {
        // Demo
    }
    
    func saveMovieIntoRealm(movies :[Movie], category: MovieCategory) {
        
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        try! realm.write {
            for movie in movies {
                let realmMovie = RealmMovie()
                realmMovie.id = Int(movie.id)
                realmMovie.title = movie.title
                realmMovie.overview = movie.overview
                realmMovie.poster_path = movie.poster_path
                realmMovie.release_date = movie.release_date
                realmMovie.popularity = movie.popularity
                realmMovie.vote_average = 0.0
                realmMovie.video = movie.video
                realmMovie.category = category.rawValue
                realm.add(realmMovie, update: true)
            }
        }
    }
}
