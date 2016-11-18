//
//  ViewController.swift
//  joelfleuren-pset3
//
//  Created by joel fleuren on 14-11-16.
//  Copyright © 2016 joel fleuren. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        search.delegate = self
        table.rowHeight = 80
        table.estimatedRowHeight = 80
        table.delegate = self
        table.dataSource = self
            
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCellID", for: indexPath) as! MovieTableViewCell
        cell.updateMovieUI(movie: movies[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "VCSegue2", sender: movies[indexPath.row])
    }
    
    // make a function to get the data from the URL
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url ) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let searchbarText = searchBar.text!
        // make shore it works for a white space
        let queryString = searchbarText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        // set the url string
        let urlString = String(format: "https://www.omdbapi.com/?t=%@&y=&plot=short&r=json", queryString!)
        // get the data from the url
        // check for errors
        getDataFromUrl(url: NSURL(string: urlString) as! URL) {
            (data, response, error) in
            guard let data = data, error == nil else { return }
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else{ return }
            do
            {
                var movie = Movie()
                // set the information from the URL in the movie file
                if let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    movie.Title = dict["Title"] as! String
                    movie.Year = dict["Year"] as! String
                    movie.Director = dict["Director"] as! String
                    movie.Actors = dict["Actors"] as! String
                    movie.Plot = dict["Plot"] as! String
                    movie.Poster = dict["Poster"] as! String
                }
            
                self.movies.append(movie)
                
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
                                
            }catch{
                print("no succes")
            }
        }
    }
    // send the information to an other viewcontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "VCSegue2" {
            let desination = segue.destination as! ViewController2
            desination.movie = sender as! Movie
        }
    }


}
