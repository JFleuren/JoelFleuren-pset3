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
        
        downloadImage(url: NSURL(string: movie.Poster) as! URL, onImageView: movieImageView)
        
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url ) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    
    func downloadImage(url: URL, onImageView: UIImageView) {
        getDataFromUrl(url: url) {
            (data, response, error)  in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { () -> Void in
                onImageView.image = UIImage(data: data)
            }
        }
    }
    
    
}
