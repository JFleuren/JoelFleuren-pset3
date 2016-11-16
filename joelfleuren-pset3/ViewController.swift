//
//  ViewController.swift
//  joelfleuren-pset3
//
//  Created by joel fleuren on 14-11-16.
//  Copyright © 2016 joel fleuren. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var table: UITableView!
    var movies: movies!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        getDataFromUrl(url: NSURL(string: "https://www.omdbapi.com/?t=Harry+Potter&y=&plot=short&r=json") as! URL) {
        (data, response, error) in
             guard let data = data, error == nil else { return }
             guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else{ return }
                do
                {
                    if let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        self.movies.Title = dict["Title"] as! String
                        self.movies.Year = dict["Year"] as! String
                        self.movies.Director = dict["Director"] as! String
                        self.movies.Actors = dict["Actors"] as! String
                        self.movies.Plot = dict["Plot"] as! String
                    }
                }catch{
                    print("no succes")
            }
        }
        
    }

    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url ) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in

            }
        }
    }

}
