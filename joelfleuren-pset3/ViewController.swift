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
    

    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url ) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    func downloadImage(url: URL) {
        getDataFromUrl(url: url) {
            (data, response, error)  in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() { () -> Void in
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let searchbarText = searchBar.text!
        let queryString = searchbarText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let urlString = String(format: "https://www.omdbapi.com/?t=%@&y=&plot=short&r=json", queryString!)
        
        getDataFromUrl(url: NSURL(string: urlString) as! URL) {
            (data, response, error) in
            guard let data = data, error == nil else { return }
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else{ return }
            do
            {
                var movie = Movie()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "VCSegue2" {
            let desination = segue.destination as! ViewController2
            desination.movie = sender as! Movie
        }
    }


}
