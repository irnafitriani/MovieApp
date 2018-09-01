//
//  CollectionTableViewCell.swift
//  MovieApp
//
//  Created by irna on 8/30/18.
//  Copyright © 2018 irna. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsetsMake(
                Constant.offset,    // top
                Constant.offset,    // left
                Constant.offset,    // bottom
                Constant.offset     // right
            )
            
            layout.minimumInteritemSpacing = Constant.minItemSpacing
            layout.minimumLineSpacing = Constant.minLineSpacing
        }
    }
    
}
