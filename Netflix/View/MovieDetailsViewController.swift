//
//  MovieDetailsViewController.swift
//  Netflix
//
//  Created by Siddhant Mishra on 19/08/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import UIKit
import HCSStarRatingView
import Kingfisher

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var addToFav: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var ratingBar: HCSStarRatingView!
    @IBOutlet weak var yearLBL: UILabel!
    @IBOutlet weak var countryLBL: UILabel!
    @IBOutlet weak var LENGTHlbl: UILabel!
    @IBOutlet weak var yearVal: UILabel!
    @IBOutlet weak var countryVal: UILabel!
    @IBOutlet weak var durationVal: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var screenshotsCollectionView: UICollectionView!
    
    var delegateView =  MovieTableViewCell()
    var scrnShotArr = [String]()
    var movieData = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews(movie: movieData!)
        setupCollectionViewData(movie: movieData!)
        setupNavigationBar()
        self.coverView = coverView.roundedImage
        self.coverImage = coverImage.roundImage
    }

    
    func setupViews(movie:Movie){
        coverImage.imageFromServerURL(movie.orignalBackgroundUrl!, placeHolder: nil)
        movieTitle.text = movie.title?.uppercased()
        ratingBar.value = CGFloat(movie.voteAverage!/2)
        overview.text = movie.overview
        durationVal.text = "\(movie.duration) mins"
        let subStr =  movie.releaseDate!.prefix(4)
        yearVal.text = String(subStr)
    }
    
    func setupCollectionViewData(movie:Movie){
        scrnShotArr.append(movie.orignalBackgroundUrl!)
        scrnShotArr.append(movie.originalPictureUrl!)
        scrnShotArr.append(movie.orignalPosterUrl!)
    }
    
    func setupNavigationBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
    }
}


extension MovieDetailsViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scrnShotArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "screenshots", for: indexPath)
        let image:UIImageView = cell.contentView.viewWithTag(1) as! UIImageView
        image.imageFromServerURL(scrnShotArr[indexPath.row], placeHolder: nil)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}





