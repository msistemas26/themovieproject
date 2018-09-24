//
//  TheMovieApi.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/23/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import Foundation
import Alamofire


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
                completion(movies.results)
        }
    }
    
    func fetchMovie(id: String, completionHandler: @escaping (Movie?, ServiceError?) -> Void) {
        // Demo
    }
    
    
}
