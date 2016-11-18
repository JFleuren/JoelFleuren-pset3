//
//  MobvieTableViewCell.swift
//  joelfleuren-pset3
//
//  Created by joel fleuren on 16-11-16.
//  Copyright © 2016 joel fleuren. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var moviePlot: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateMovieUI(movie: Movie) {
        
        print("updateMovieUI: ")
        
        movieTitleLabel.text = movie.Title
        moviePlot.text = movie.Plot
    }
    
    
}
