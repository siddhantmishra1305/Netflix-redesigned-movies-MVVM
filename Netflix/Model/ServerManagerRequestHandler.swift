//
//  ServerManagerRequestHandler.swift
//  Contacts
//
//  Created by Siddhant Mishra on 30/05/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import Foundation
import Alamofire

internal enum ServerRequestRouter: URLRequestConvertible{
    
    static var baseURLString:String{
        return "https://api.themoviedb.org/3/"
    }
    
    case getHighestRatedMovies
    case getNowPlayingMovies
    case getUpcomingMovies
    case getPopularMovies
    case getMovieDetails(Int)
    

    var httpMethod:Alamofire.HTTPMethod {
        switch self {
        case .getHighestRatedMovies:
           return .get
        case .getNowPlayingMovies:
            return .get
        case .getUpcomingMovies:
            return .get
        case .getPopularMovies:
            return .get
        case .getMovieDetails(_):
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getHighestRatedMovies:
            return "\(ServerRequestRouter.baseURLString)"+"discover/movie"
        case .getNowPlayingMovies:
            return "\(ServerRequestRouter.baseURLString)"+"movie/now_playing"
        case .getUpcomingMovies:
            return "\(ServerRequestRouter.baseURLString)"+"movie/upcoming"
        case .getPopularMovies:
            return "\(ServerRequestRouter.baseURLString)"+"movie/popular"
        case .getMovieDetails(_):
            return "\(ServerRequestRouter.baseURLString)"+"movie/"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let URL = Foundation.URL(string: path)!
        var mutableURLRequest = URLRequest(url: URL)
        mutableURLRequest.httpMethod = httpMethod.rawValue
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        switch  self {
        case .getHighestRatedMovies:
            do{
            
                var params = [String:Any]()
                params["api_key"] = "4cb1eeab94f45affe2536f2c684a5c9e"
                params["language"] = "\(Locale.preferredLanguages.first ?? "en-US")"
                params["certification_country"] = Locale.current.regionCode?.uppercased()
                params["certification"] = "R"
                params["sort_by"] = "vote_average.desc"
                
                

                let encoding = URLEncoding(destination: URLEncoding.Destination.queryString)
                return try encoding.encode(mutableURLRequest, with: params)
            } catch {
                return mutableURLRequest
            }
        case .getNowPlayingMovies:
            do{
                var params  = [String:Any]()
                params["api_key"] = "4cb1eeab94f45affe2536f2c684a5c9e"
                params["language"] = "\(Locale.preferredLanguages.first ?? "en-US")"
                params["region"] = Locale.current.regionCode?.uppercased()
                
                let encoding = URLEncoding(destination: URLEncoding.Destination.queryString)
                return try encoding.encode(mutableURLRequest, with: params)
            } catch {
                return mutableURLRequest
            }
        case .getUpcomingMovies:
            do{
                var params = [String:Any]()
                params["api_key"] = "4cb1eeab94f45affe2536f2c684a5c9e"
                params["language"] = "\(Locale.preferredLanguages.first ?? "en-US")"
                params["region"] = Locale.current.regionCode?.uppercased()
                
                
                 let encoding = URLEncoding(destination: URLEncoding.Destination.queryString)
                return try encoding.encode(mutableURLRequest, with: params)
            } catch {
                return mutableURLRequest
            }
        case .getPopularMovies:
            do{
                var params = [String:Any]()
                params["api_key"] = "4cb1eeab94f45affe2536f2c684a5c9e"
                params["language"] = "\(Locale.preferredLanguages.first ?? "en-US")"
                params["region"] = Locale.current.regionCode?.uppercased()
                
                
                let encoding = URLEncoding(destination: URLEncoding.Destination.queryString)
                return try encoding.encode(mutableURLRequest, with: params)
            } catch {
                return mutableURLRequest
            }
        case .getMovieDetails(let id):
            do{
                var params = [String:Any]()
                params["api_key"] = "4cb1eeab94f45affe2536f2c684a5c9e"
                params["language"] = "\(Locale.preferredLanguages.first ?? "en-US")"
                
                let url = Foundation.URL(string: path + "\(id)")
                mutableURLRequest = URLRequest(url: url!)
                let encoding = URLEncoding(destination: URLEncoding.Destination.queryString)
                return try encoding.encode(mutableURLRequest, with: params)
            } catch {
                return mutableURLRequest
            }
        }
    }
}
