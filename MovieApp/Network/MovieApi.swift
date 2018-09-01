//
//  MovieApi.swift
//  MovieApp
//
//  Created by irna on 8/28/18.
//  Copyright © 2018 irna. All rights reserved.
//

import Foundation
import Moya

enum MovieApi {
    case nowPlaying(page: Int)
    case similar(id: Int)
}

extension MovieApi: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/") else { fatalError("baseURL could not be configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .nowPlaying:
            return "now_playing"
        case .similar(let id):
            return "\(id)/similar"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .nowPlaying, .similar:
            return .get
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .nowPlaying, .similar:
            return URLEncoding.queryString
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .similar(let id):
            return ["movie_id" : id, "api_key": API.apiKey]
        case .nowPlaying(let page):
            return ["page" : page, "api_key" : API.apiKey]
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .nowPlaying, .similar:
            return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
        }
    }
    
    var headers: [String : String]? {
        return [String : String]()
    }
}
