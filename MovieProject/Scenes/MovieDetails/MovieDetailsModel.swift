//
//  MovieDetailsModel.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/23/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import Foundation

enum MovieDetails
{
    // MARK: Use cases
    
    enum GetMovie
    {
        struct Request
        {
        }
        struct Response
        {
            var movie: Movie
        }
        struct ViewModel
        {
            struct DisplayedMovie
            {
                let id: Int64
                let title :String
                let overview: String
                let poster_path: String
                let release_date: String
                let popularity: Double
                let vote_average: Double
                let video: Bool
            }
            var displayedMovie: DisplayedMovie
        }
    }
}
