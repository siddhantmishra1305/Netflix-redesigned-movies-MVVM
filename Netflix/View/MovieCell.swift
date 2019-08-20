//
//  MovieCell.swift
//  Netflix
//
//  Created by Siddhant Mishra on 14/08/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var movieCover: UIImageView!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    
    var cellData = String(){
        didSet{
            movieCover.imageFromServerURL(cellData, placeHolder: #imageLiteral(resourceName: "placeholder"))
            activityLoader.stopAnimating()
            self.layer.giveShadowToTableViewCell(layer: self.layer, Bounds: self.bounds, cornerRadius: 10.0)
           
        }
    }
}
