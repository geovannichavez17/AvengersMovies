//
//  MoviesService.swift
//  AvengersMovies
//
//  Created by Geovanni Josue Chavez on 28/2/24.
//


import Alamofire

protocol MoviesServiceTasks {
    func getMovies(completionHandler: @escaping (Result<MoviesReponse, Error>) -> Void)
    func getMoviesByKeyword(keyword: String, completionHandler: @escaping (Result<MoviesReponse, Error>) -> Void)
    func getMovieDetails(movieId: String, completionHandler: @escaping (Result<MovieDetailsResponse, Error>) -> Void)
}

class MoviesService: BaseService<MoviesTarget>, MoviesServiceTasks {
    
    func getMovies(completionHandler: @escaping (Result<MoviesReponse, Error>) -> Void) {
        self.request(target: .getMovies, responseClass: MoviesReponse.self) { result in
            completionHandler(result)
        }
    }
    
    func getMoviesByKeyword(keyword: String, completionHandler: @escaping (Result<MoviesReponse, Error>) -> Void) {
        self.request(target: .getMoviesBySearch(keyword: keyword), responseClass: MoviesReponse.self) { result in
            completionHandler(result)
        }
    }
    
    func getMovieDetails(movieId: String, completionHandler: @escaping (Result<MovieDetailsResponse, Error>) -> Void) {
        self.request(target: .getMovieDetails(movieId: movieId), responseClass: MovieDetailsResponse.self) { result in
            completionHandler(result)
        }
    }
}

