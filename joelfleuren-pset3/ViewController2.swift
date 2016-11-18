//
//  ViewController2.swift
//  joelfleuren-pset3
//
//  Created by joel fleuren on 14-11-16.
//  Copyright © 2016 joel fleuren. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    var movie: Movie!

    @IBOutlet weak var poster: UIImageView!
   
    @IBOutlet weak var name: UITextView!
    @IBOutlet weak var year: UITextView!
    @IBOutlet weak var director: UITextView!
    @IBOutlet weak var cast: UITextView!
    @IBOutlet weak var plot: UITextView!
    
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI(movie: movie)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func updateUI(movie: Movie) {
        // set al the information on the screen
        name.text = movie.Title
        year.text = movie.Year
        director.text = movie.Director
        cast.text = movie.Actors
        plot.text = movie.Plot
        // download the image from the Url
        downloadImage(url: NSURL(string: movie.Poster) as! URL, onImageView: poster)
        
    }
    // make a function to load the info form the URL
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url ) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    // make a function to download the image that is in a other URL
    func downloadImage(url: URL, onImageView: UIImageView) {
        getDataFromUrl(url: url) {
            (data, response, error)  in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { () -> Void in
               onImageView.image = UIImage(data: data)
            }
        }
    }
    @IBAction func buttonClicked(button: UIButton){
        UserD
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
