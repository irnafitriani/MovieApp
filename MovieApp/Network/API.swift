//
//  API.swift
//  MovieApp
//
//  Created by irna on 8/28/18.
//  Copyright © 2018 irna. All rights reserved.
//

import Foundation
import Moya

class API {
    
    static let apiKey = "0a23da116738f3a1a0ec7de5e221428f"
    static let apiReadAcccessToke  = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwYTIzZGExMTY3MzhmM2ExYTBlYzdkZTVlMjIxNDI4ZiIsInN1YiI6IjVhY2VkZDVhYzNhMzY4N2UyNzA1MmYxNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.WEjPLGaBZ60hacynnTFqvzARftUwwq64hBsyYdi1jsA"
    static let imageURL = "https://image.tmdb.org/t/p/w1280"

    static let provider = MoyaProvider<MovieApi>(plugins: [NetworkLoggerPlugin(verbose: true)]) // for development
    
    static func getNowPlaying(page: Int, completion: @escaping(MovieResults) -> ()){
        provider.request(.nowPlaying(page:page)) { results in
            switch results {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(MovieResults.self, from: response.data)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    static func getSimilar(forMoviesWith id:Int, completion: @escaping (MovieResults) -> ()) {
        provider.request(.similar(id: id)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(MovieResults.self, from: response.data)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
