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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        poster.image = (movie.Image)
        name.text = (movie.Title)
        year.text = (movie.Year)
        director.text = (movie.Director)
        cast.text = (movie.Actors)
        plot.text = (movie.Plot)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
