//
//  NowPlayingTableViewCell.swift
//  MovieApp
//
//  Created by irna on 8/30/18.
//  Copyright © 2018 irna. All rights reserved.
//

import UIKit
import Kingfisher

class NowPlayingTableViewCell: UITableViewCell {
    @IBOutlet weak var imgNowPlaying: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ model: Movie) {
        guard let posterPath = model.posterPath else { return }
        let imgUrl = URL(string: API.imageURL + posterPath)
        imgNowPlaying.kf.setImage(with: imgUrl)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
