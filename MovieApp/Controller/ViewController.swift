//
//  ViewController.swift
//  MovieApp
//
//  Created by irna on 8/28/18.
//  Copyright © 2018 irna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tblMovie: UITableView!
    
    var dataMovies = [Movie?]()
    var page = 1
    var totalPages = 0
    var selectedMovie : Movie!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "Movie App"
        self.callMovieApi()
        
    }
    
    func callMovieApi(){
        API.getNowPlaying(page: page, completion: { movieResults in
            self.totalPages = movieResults.totalPages ?? 0
            
            for movie in movieResults.results {
                self.dataMovies.append(movie)
            }
            self.page = self.page + 1
            self.tblMovie.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail"{
            let detailMovieVC = segue.destination as! MovieDetailViewController
            detailMovieVC.selectedMovie = self.selectedMovie
            guard let posterPath = self.selectedMovie.posterPath else {return}
            let imgUrl = URL(string: API.imageURL + posterPath)
            detailMovieVC.imgPosterURL = imgUrl
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.dataMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NowPlayingCell", for: indexPath) as! NowPlayingTableViewCell
        
        guard let dataRow = self.dataMovies[indexPath.row] else { return cell}
        cell.configure(dataRow)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = self.dataMovies.count - 1
        if indexPath.row == lastItem{
            if page != totalPages{
               self.callMovieApi()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dataRow = self.dataMovies[indexPath.row] else {
            print("No movie selected")
            return
        }
        self.selectedMovie = dataRow
        self.performSegue(withIdentifier: "goToDetail", sender: self)
    }
    
    
}
