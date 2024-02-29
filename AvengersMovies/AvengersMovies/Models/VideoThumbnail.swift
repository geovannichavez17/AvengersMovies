//
//  VideoThumbnail.swift
//  AvengersMovies
//
//  Created by Geovanni Josue Chavez on 28/2/24.
//

import Foundation

struct VideoThumbnail {
    var title: String?
    var thumbnailUrl: String?
    var channelIconUrl: String?
    var videoKey: String?
    
    init(title: String? = nil, thumbnailUrl: String? = nil, channelIconUrl: String? = nil, videoKey: String? = nil) {
        self.title = title
        self.thumbnailUrl = thumbnailUrl
        self.channelIconUrl = channelIconUrl
        self.videoKey = videoKey
    }
}
