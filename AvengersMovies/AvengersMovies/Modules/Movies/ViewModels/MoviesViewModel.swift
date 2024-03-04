//
//  MoviesViewModel.swift
//  AvengersMovies
//
//  Created by Geovanni Josue Chavez on 28/2/24.
//

import Foundation

class MoviesViewModel {
    
    private let moviesService: MoviesService?
    var coordinator: MoviesCoordinator?
    
    var moviesDataSource: Observable<[Movie]> = Observable(nil)
    var isLoading: Observable<Bool> = Observable(false)
    var errorMessage: Observable<String> = Observable(nil)
    
    init(coordinator: MoviesCoordinator) {
        self.coordinator = coordinator
        self.moviesService = MoviesService()
    }
    
    func retrieveMovies() {
        if isLoading.value ?? true { return }
        isLoading.value = true
        
        moviesService?.getMoviesByKeyword(keyword: Constants.APIs.keywordID) { [weak self] result in
            guard let self = self else { return }
            self.isLoading.value = false
            self.errorMessage.value = nil
            //self.nowPlayingPage += 1
            //handleService(result: result, category: category)
            
            switch result {
            case .success(let response):
                if moviesDataSource.value == nil {
                    moviesDataSource.value = response.movies
                } else {
                    guard let movies = response.movies else { return }
                    moviesDataSource.value?.append(contentsOf: movies)
                }
            case .failure:
                errorMessage.value = Constants.Common.labelError
            }
        }
    }
}

