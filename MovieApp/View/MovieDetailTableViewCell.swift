//
//  MovieDetailTableViewCell.swift
//  MovieApp
//
//  Created by irna on 8/30/18.
//  Copyright © 2018 irna. All rights reserved.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblReleaseYear: UILabel!
    @IBOutlet weak var lblMovieDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ model: Movie) {
        guard let releaseDate = model.releaseDate, let overview = model.overview, let title = model.originalTitle else {
            return
        }
        lblMovieTitle.text = "Title : " + title
        lblReleaseYear.text = "Release Year : " + releaseDate
        lblMovieDesc.text = "Description : " + overview
    }

}
