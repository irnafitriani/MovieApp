//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by irna on 8/30/18.
//  Copyright © 2018 irna. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    var selectedMovie : Movie!
    var similarMovie : [Movie] = []
    var imgPosterURL : URL!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tblView.estimatedRowHeight = 50
        self.navigationItem.title = selectedMovie.originalTitle
    
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.callSimilarMovieApi()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeDetailView(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func callSimilarMovieApi(){
        guard let movieId = selectedMovie.id else {
            return
        }
        API.getSimilar(forMoviesWith: movieId, completion: { movieResults in
            
            for movie in movieResults.results {
                self.similarMovie.append(movie)
            }
            self.tblView.reloadData()
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell =  tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath)
            let headerImage = cell.viewWithTag(1) as! UIImageView
            headerImage.kf.setImage(with: self.imgPosterURL)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailCell", for: indexPath) as! MovieDetailTableViewCell
            cell.configure(selectedMovie)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell", for: indexPath) as! CollectionTableViewCell
            cell.collectionView.reloadData()
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return UITableViewAutomaticDimension
        case 1:
            return UITableViewAutomaticDimension
        case 2:
            let itemHeight = Constant.getItemWidth(boundWidth: tableView.bounds.size.width)

            let totalRow = ceil(CGFloat (similarMovie.count) / Constant.column)

            let totalTopBottomOffset = Constant.offset + Constant.offset

            let totalSpacing = CGFloat(totalRow - 1) * Constant.minLineSpacing

            let totalHeight  = ((itemHeight * CGFloat(totalRow)) + totalTopBottomOffset + totalSpacing)

            return totalHeight
        default:
            return UITableViewAutomaticDimension
        }
    }
}

extension MovieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.similarMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BoxCell", for: indexPath)
        let dataCollection = self.similarMovie[indexPath.row]
        let imgPoster = cell.viewWithTag(1) as! UIImageView
        
        guard let posterPath = dataCollection.posterPath else { return cell }
        
        let imgUrl = URL(string: API.imageURL + posterPath)
        imgPoster.kf.setImage(with: imgUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSimilarMovie = self.similarMovie[indexPath.row]
        
        // Safe Push VC
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailVC") as? MovieDetailViewController {
            viewController.selectedMovie = selectedSimilarMovie
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
        
    }
}

extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = Constant.getItemWidth(boundWidth: collectionView.bounds.size.width)
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
}
