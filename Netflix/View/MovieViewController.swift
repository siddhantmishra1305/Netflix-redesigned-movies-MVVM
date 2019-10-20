//
//  ViewController.swift
//  Netflix
//
//  Created by Siddhant Mishra on 13/08/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import UIKit
import FSPagerView
class MovieViewController: UIViewController {

    @IBOutlet weak var moviesList: UITableView!
    
    var viewModel = MoviesViewModel()
    var movies = [[String:[Movie]]]()
    var selectedMovie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarButtons()
        
        moviesList.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        moviesList.register(UINib(nibName: "PagerCell", bundle: nil), forCellReuseIdentifier: "PagerCell")
        
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if movies.count == 0 {
            getAllData()
        }
    }
    
    func getAllData(){
        movies.removeAll()
        viewModel.getMovies(type: .HighestRated)
        viewModel.getMovies(type: .NowPlaying)
        viewModel.getMovies(type: .Popular)
        viewModel.getMovies(type: .Upcoming)
    }
    
}

extension MovieViewController: UITableViewDelegate,UITableViewDataSource{
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 205
        } else {
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        if section == 0 {
            let view = UIView()
           return view
        } else{
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
            let label = UILabel()
            label.frame = CGRect.init(x: 5, y: 12, width: headerView.frame.width, height: headerView.frame.height-8)
            label.font = UIFont(name: "HelveticaNeue-Bold", size: 15.0)
            label.textColor = #colorLiteral(red: 0.1568627451, green: 0.1568627451, blue: 0.1568627451, alpha: 1)
            headerView.backgroundColor = .white
            
            let data = Array(movies[section].keys)
            if data.count > 0 {
                label.text = data[0]
            }
            headerView.addSubview(label)
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        } else{
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PagerCell", for: indexPath) as! PagerCell
            let data = movies[indexPath.section]
            cell.cellData = data.first!.value
            return cell
        } else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
            let data = movies[indexPath.section]
            cell.movies = data.first!.value
            cell.movieDelegate = self
            return cell
        }
    }
}

extension MovieViewController:ViewModelDelegate{
    func reloadTable(movieArr: [String : [Movie]]) {
        movies.append(movieArr)
        moviesList.reloadData()
    }
}

extension MovieViewController{
    func  setupNavigationBarButtons(){
        
        let menuBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(openHamburgerMenu))
        self.navigationItem.leftBarButtonItem = menuBtn
        
        let searchBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "search"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(openSearchScreen))
        self.navigationItem.rightBarButtonItem = searchBtn
    
    }
    
    @objc func openHamburgerMenu(){
    
    }
    
    @objc func openSearchScreen(){
        
    }
    
    
}

extension MovieViewController: SelectedMovieDelegate{
    func didSelectMovie(movie: Movie) {
        selectedMovie = movie
        self.performSegue(withIdentifier: "showDetail", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            let controller = segue.destination as! MovieDetailsViewController
            controller.movieData = selectedMovie
        }
    }
}

