//
//  BeerDataModel.swift
//  BeerCraft
//
//  Created by Siddhant Mishra on 27/07/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import Foundation
import ObjectMapper

typealias Movie = MovieData

struct MovieData: Mappable {

    public var id: Int = 0
    public var title: String?
    public var smallPictureUrl: String?
    public var originalPictureUrl: String?
    public var smallBackgroundUrl: String?
    public var orignalBackgroundUrl: String?
    public var posterPath : String?
    public var orignalPosterUrl : String?
    public var duration: String = String(Int.random(in: 90..<150))
    public var voteAverage: Double?
    public var releaseDate: String?
    
    

    public var pictureURL: String?{
        didSet{
            smallPictureUrl = "https://image.tmdb.org/t/p/w500\(pictureURL ?? "")"
            originalPictureUrl = "https://image.tmdb.org/t/p/original\(pictureURL ?? "")"
        }
    }

    public var backgroundURL: String?{
        didSet{
            smallBackgroundUrl = "https://image.tmdb.org/t/p/w500\(backgroundURL ?? "")"
            orignalBackgroundUrl = "https://image.tmdb.org/t/p/original\(backgroundURL ?? "")"
        }
    }
    
    public var poster: String?{
        didSet{
            posterPath = "https://image.tmdb.org/t/p/w500\(poster ?? "")"
            orignalPosterUrl = "https://image.tmdb.org/t/p/original\(poster ?? "")"
        }
    }

    public var overview: String?

    init?(map: Map) {

    }

    init?() {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        title <- map["title"]
        pictureURL <- map["poster_path"]
        backgroundURL <- map["backdrop_path"]
        overview <- map["overview"]
        poster <- map["poster_path"]
        voteAverage <- map["vote_average"]
        releaseDate <- map["release_date"]
    }

}
