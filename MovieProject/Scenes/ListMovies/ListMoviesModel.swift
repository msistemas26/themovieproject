//
//  ListMoviesModel.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/23/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import Foundation


enum ListMovies
{
    // MARK: Use cases
    
    enum FetchMovies
    {
        struct Request
        {
        }
        struct Response
        {
            var movies: [Movie]
        }
        struct ViewModel
        {
            struct DisplayedMovie
            {
                let id: Int
                let title :String
                let overview: String
                let poster_path: String
            }
            var displayedMovies: [DisplayedMovie]
        }
    }
}
