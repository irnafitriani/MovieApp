//
//  Movie.swift
//  MovieApp
//
//  Created by irna on 8/28/18.
//  Copyright © 2018 irna. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var voteCount, id: Int?
    var video: Bool?
    var voteAverage: Double?
    var title: String?
    var popularity: Double?
    var posterPath, originalLanguage, originalTitle: String?
    var genreIDS: [Int]?
    var backdropPath: String?
    var adult: Bool?
    var overview, releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id, video
        case voteAverage = "vote_average"
        case title, popularity
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult, overview
        case releaseDate = "release_date"
    }
}

struct Dates: Codable {
    let maximum, minimum: String?
}


struct MovieResults: Decodable {
    var results: [Movie]
    var page, totalResults: Int?
    var dates: Dates?
    var totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults = "total_results"
        case dates
        case totalPages = "total_pages"
    }
}
