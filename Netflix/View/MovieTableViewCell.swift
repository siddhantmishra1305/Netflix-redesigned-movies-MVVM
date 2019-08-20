//
//  MovieTableViewCell.swift
//  Netflix
//
//  Created by Siddhant Mishra on 14/08/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import UIKit

protocol SelectedMovieDelegate: class {
    func didSelectMovie(movie:Movie)
}

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var MoviesCollectionView: UICollectionView!
    weak var movieDelegate:SelectedMovieDelegate!
    
    var movies = [Movie](){
        didSet{
            MoviesCollectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
            MoviesCollectionView.reloadData()
        }
    }
}

extension MovieTableViewCell:UICollectionViewDataSource{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.cellData = movies[indexPath.row].orignalPosterUrl!
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
    }
}

extension MovieTableViewCell:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            self.movieDelegate?.didSelectMovie(movie: movies[indexPath.row])
    }
}



