//
//  Movie.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/23/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import Foundation

struct Movie: Codable
{
    let id: Int
    let title :String
    let overview: String
    let poster_path: String
    let release_date: String
    let popularity: Double
    let vote_average: Double
    let video: Bool
}

struct MovieList: Codable {
    let results: [Movie]
}
