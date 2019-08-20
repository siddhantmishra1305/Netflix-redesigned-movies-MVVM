//
//  ServerManager.swift
//  Contacts
//
//  Created by Siddhant Mishra on 30/05/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import Alamofire

public enum ServerErrorCodes: Int{
    case notFound = 404
    case validationError = 422
    case internalServerError = 500
    
}


public enum ServerErrorMessages: String{
    case notFound = "Not Found"
    case validationError = "Validation Error"
    case internalServerError = "Internal Server Error"
}


public enum ServerError: Error{
    case systemError(Error)
    case customError(String)
    
    public var details:(code:Int ,message:String){
        switch self {
            
        case .customError(let errorMsg):
            switch errorMsg {
            case "Not Found":
                return (ServerErrorCodes.notFound.rawValue,ServerErrorMessages.notFound.rawValue)
            case "Validation Error":
                return (ServerErrorCodes.validationError.rawValue,ServerErrorMessages.validationError.rawValue)
            case "Internal Server Error":
                 return (ServerErrorCodes.internalServerError.rawValue,ServerErrorMessages.internalServerError.rawValue)
            default:
                return (ServerErrorCodes.internalServerError.rawValue,ServerErrorMessages.internalServerError.rawValue)
            }
            
        case .systemError(let errorCode):
            return (errorCode._code,errorCode.localizedDescription)
        }
    }
}

public struct ServerManager{
    
    static let sharedInstance = ServerManager()
    
    func getHighestRatedMovies(_ handler:@escaping ([Movie?],ServerError?) -> Void){
        
        Alamofire.request(ServerRequestRouter.getHighestRatedMovies).validate().responseJSON
            {(response) in
            
            switch response.result {
        
            case .success:
                
                    let json = response.result.value as? [String: Any]
                    let results = json!["results"] as? [[String:Any]]
                    var arr = [Movie]()
                    for item in results!{
                        let data = Movie(JSON: item)
                        arr.append(data!)
                    }
                    print(arr)
                    handler(arr,nil)
                
            case .failure(let error):

                print(error)
                if error.localizedDescription .contains("404"){
                    handler([],ServerError.customError("Not Found"))
                } else if error.localizedDescription.contains("422") {
                    handler([],ServerError.customError("Validation Error"))
                } else if error.localizedDescription.contains("500"){
                    handler([],ServerError.customError("Internal Server Error"))
                }
                else{
                    handler([],ServerError.systemError(error))
                }
            }
        }
    }
    
    func getNowPlayingMovies(_ handler:@escaping ([Movie?],ServerError?) -> Void){
        
        Alamofire.request(ServerRequestRouter.getNowPlayingMovies).validate().responseJSON
            {(response) in
                
                switch response.result {
                    
                case .success:
                    
                    let json = response.result.value as? [String: Any]
                    let results = json!["results"] as? [[String:Any]]
                    var arr = [Movie]()
                    for item in results!{
                        let data = Movie(JSON: item)
                        arr.append(data!)
                    }
//                    print(arr)
                    handler(arr,nil)
                    
                case .failure(let error):
                    print(error)
                    if error.localizedDescription .contains("404"){
                        handler([],ServerError.customError("Not Found"))
                    } else if error.localizedDescription.contains("422") {
                        handler([],ServerError.customError("Validation Error"))
                    } else if error.localizedDescription.contains("500"){
                        handler([],ServerError.customError("Internal Server Error"))
                    }
                    else{
                        handler([],ServerError.systemError(error))
                    }
                }
        }
    }
    
    func getPopularMovies(_ handler:@escaping ([Movie?],ServerError?) -> Void){
        
        Alamofire.request(ServerRequestRouter.getPopularMovies).validate().responseJSON
            {(response) in
                
                switch response.result {
                    
                case .success:
                    
                    let json = response.result.value as? [String: Any]
                    let results = json!["results"] as? [[String:Any]]
                    var arr = [Movie]()
                    for item in results!{
                        let data = Movie(JSON: item)
                        arr.append(data!)
                    }
                    print(arr)
                    handler(arr,nil)
                    
                case .failure(let error):
                    print(error)
                    if error.localizedDescription .contains("404"){
                        handler([],ServerError.customError("Not Found"))
                    } else if error.localizedDescription.contains("422") {
                        handler([],ServerError.customError("Validation Error"))
                    } else if error.localizedDescription.contains("500"){
                        handler([],ServerError.customError("Internal Server Error"))
                    }
                    else{
                        handler([],ServerError.systemError(error))
                    }
                }
        }
    }
    
    func getUpcomingMovies(_ handler:@escaping ([Movie?],ServerError?) -> Void){
        
        Alamofire.request(ServerRequestRouter.getUpcomingMovies).validate().responseJSON
            {(response) in
                
                switch response.result {
                    
                case .success:
                    
                    let json = response.result.value as? [String: Any]
                    let results = json!["results"] as? [[String:Any]]
                    var arr = [Movie]()
                    for item in results!{
                        let data = Movie(JSON: item)
                        arr.append(data!)
                    }
                    print(arr)
                    handler(arr,nil)
                    
                case .failure(let error):
                    print(error)
                    if error.localizedDescription .contains("404"){
                        handler([],ServerError.customError("Not Found"))
                    } else if error.localizedDescription.contains("422") {
                        handler([],ServerError.customError("Validation Error"))
                    } else if error.localizedDescription.contains("500"){
                        handler([],ServerError.customError("Internal Server Error"))
                    }
                    else{
                        handler([],ServerError.systemError(error))
                    }
                }
        }
    }
    
    func getMovieDetails(_ id:Int, handler:@escaping (Movie?,ServerError?) -> Void){
        
        Alamofire.request(ServerRequestRouter.getMovieDetails(id)).validate().responseJSON
            {(response) in
                
                switch response.result {
                    
                case .success:
                    
                    let json = response.result.value as? [String: Any]
                    var arr = [Movie]()
                    let data = Movie(JSON: json!)
                    print(arr)
                    handler(data,nil)
                    
                case .failure(let error):
                    print(error)
                    if error.localizedDescription .contains("404"){
                        handler(nil,ServerError.customError("Not Found"))
                    } else if error.localizedDescription.contains("422") {
                        handler(nil,ServerError.customError("Validation Error"))
                    } else if error.localizedDescription.contains("500"){
                        handler(nil,ServerError.customError("Internal Server Error"))
                    }
                    else{
                        handler(nil,ServerError.systemError(error))
                    }
                }
        }
    }
}
