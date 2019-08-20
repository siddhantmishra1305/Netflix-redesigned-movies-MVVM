//
//  MoviesViewModel.swift
//  Netflix
//
//  Created by Siddhant Mishra on 14/08/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    func reloadTable(movieArr:[String:[Movie]])
}

class MoviesViewModel {
    
    var movies = [[String:[Movie]]]()
    var movieHeader = [String]()
    weak var delegate: ViewModelDelegate?
    
    func getMovies(type:ListType)  {
        
        switch type {
      
            case .HighestRated:
                ServerManager.sharedInstance.getHighestRatedMovies() { [unowned self](details, error) in

                    if let error = error {
                        print(error.details.message)
                    }
                    else {
                        self.delegate?.reloadTable(movieArr: ["Highest Rated":details as! Array<Movie>])
                    }
                }
                break
            
            case .NowPlaying:
                ServerManager.sharedInstance.getNowPlayingMovies(){[unowned self] (details,error) in
                
                    if let error = error {
                        print(error.details.message)
                    }
                    else {
                        self.delegate?.reloadTable(movieArr: ["Now Playing":details as! Array<Movie>])
                    }
                }
                break
            
            case .Popular:
                ServerManager.sharedInstance.getPopularMovies(){[unowned self] (details,error) in
                
                    if let error = error {
                        print(error.details.message)
                    }
                    else {
                        self.delegate?.reloadTable(movieArr: ["Popular Movies":details as! Array<Movie>])
                    }
                }
                break
            
            case .Upcoming:
                ServerManager.sharedInstance.getUpcomingMovies(){[unowned self] (details,error) in
                
                    if let error = error {
                        print(error.details.message)
                    }
                    else {
                        self.delegate?.reloadTable(movieArr: ["Upcoming Movies":details as! Array<Movie>])
                    }
                }
                break
        }
    }
    
//    func getMovieDetails(id:Int){
//        ServerManager.sharedInstance.getMovieDetails(id){ [unowned self] (details,error) in
//
//            if let error = error {
//                print(error.details.message)
//            }
//            else {
//                self.delegate?.reloadTable(movieArr: ["Highest Rated":details as! Array<Movie>])
//            }
//        }
//    }
}
