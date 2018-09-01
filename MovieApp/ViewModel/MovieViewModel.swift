//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by irna on 8/30/18.
//  Copyright © 2018 irna. All rights reserved.
//

import Foundation

class MovieViewModel : NSObject{
    
    var movieItems = [Movie?]()
    
    var movieItemsCount: Int {
        return movieItems.count
    }
    
    func movieItem(at index: Int) -> Movie?{
        guard index >= 0 && index < movieItemsCount else { return nil }
        return movieItems[index]
    }
}
