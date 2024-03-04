//
//  MoviesTarget.swift
//  AvengersMovies
//
//  Created by Geovanni Josue Chavez on 28/2/24.
//


import Alamofire
import Foundation

enum MoviesTarget {
    case getMovies
    case getMoviesBySearch(keyword: String)
    case getMovieDetails(movieId: String)
    case getTrailerThumbnail(movieId: String)
}

extension MoviesTarget: BaseTarget {
    var baseURL: String {
        switch self {
        case .getTrailerThumbnail:
            return Constants.APIs.youTubeThumbnailUrl
        default:
            return Constants.APIs.baseUrl
        }
    }
    
    var path: String {
        switch self {
        case .getMoviesBySearch(let keyword):
            return "\(Constants.APIs.search)\(keyword)"
        case .getMovieDetails(let movieId):
            return "movie/\(movieId)\(Constants.APIs.movieDetails)"
        case .getMovies:
            return Constants.APIs.movies
        case .getTrailerThumbnail(let movieId):
            return "/\(movieId)/\(Constants.APIs.thumbnailResolution)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMovies,
             .getMoviesBySearch,
             .getMovieDetails:
            return .get
        case .getTrailerThumbnail:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getMovies,
             .getMoviesBySearch,
             .getMovieDetails:
            return .requestPlain
        case .getTrailerThumbnail:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getMovieDetails:
            return [String: String]()
        default:
            return [:]
        }
    }
    
}

