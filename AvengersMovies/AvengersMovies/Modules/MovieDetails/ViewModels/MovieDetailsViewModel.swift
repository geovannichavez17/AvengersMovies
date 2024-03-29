//
//  MovieDetailsViewModel.swift
//  AvengersMovies
//
//  Created by Geovanni Josue Chavez on 28/2/24.
//

import Foundation
import UIKit

class MovieDetailsViewModel {
    
    // Observables
    var movie: Observable<Movie> = Observable(nil)
    var videos: Observable<Video> = Observable(nil)
    var crew: Observable<[Cast]> = Observable(nil)
    var similarFilms: Observable<[SimilarResult]> = Observable(nil)
    var streamingProvider: Observable<[WatchProvider]> = Observable(nil)
    var videoItems: Observable<[VideoThumbnail]> = Observable(nil)
    var isLoading: Observable<Bool> = Observable(false)
    var errorMessage: Observable<String> = Observable(nil)
    
    // Properties
    let moviesService: MoviesService?
    let coordinator: MoviesCoordinator?
    var thumbnailsUrls: [VideoThumbnail]?
    
    
    init(coordinator: MoviesCoordinator, movie: Movie) {
        self.movie.value = movie
        self.coordinator = coordinator
        moviesService = MoviesService()
        thumbnailsUrls = [VideoThumbnail]()
    }
    
    func retrieveMovieDetails() {
        if isLoading.value ?? true { return }
        guard let movie = self.movie.value else { return }

        isLoading.value = true
        let movieID = String(movie.id ?? 0)
        moviesService?.getMovieDetails(movieId: movieID) { [weak self] result in
            guard let self = self else { return }
            self.isLoading.value = false
            
            switch result {
            case .success(let response):
                self.crew.value = response.credits.cast
                self.similarFilms.value = response.similar.similarResults
                self.streamingProvider.value = response.watchProviders.providerResults?.us?.flatrate
                
                // Get trailer videos
                guard let videos = response.videos.videos else { return }
                let trailers = videos.filter { $0.type == "Trailer" }
                
                for video in trailers {
                    let thumbnailUrl = "\(Constants.APIs.youTubeThumbnailUrl)/\(video.key ?? "")/\(Constants.APIs.thumbnailResolution)"
                    let newItem = VideoThumbnail(title: video.name, thumbnailUrl: thumbnailUrl, videoKey: video.key)
                    thumbnailsUrls?.append(newItem)
                }
                self.videoItems.value = thumbnailsUrls
                        
            case .failure:
                errorMessage.value = Constants.Common.labelError
            }
        }
    }
    
    func playTrailerVideo(videoKey: String) {
        guard let youtubeURL = URL(string: "\(Constants.APIs.youTubeAppLink)\(videoKey)") else { return }
        
        if UIApplication.shared.canOpenURL(youtubeURL) {
            UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
        } else {
            guard let webUrl = URL(string: "\(Constants.APIs.youTubeUrl)\(videoKey)") else { return }
            UIApplication.shared.open(webUrl, options: [:], completionHandler: nil)
        }
    }
}

