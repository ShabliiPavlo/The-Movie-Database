//
//  ViewController.swift
//  The Movie Database
//
//  Created by Pavel Shabliy on 01.03.2023.
//

import UIKit
import Alamofire

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var moviesOrSeriesSegmentedontrol: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var moviesTbleView: UITableView!
    
    var arrayOfMovies = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMoviesTitle()
    }
    
    //MARK - данные названия фильмов в таблицу .reloadData()
    func getMoviesTitle() {
        let urlSerchingMovie = "https://api.themoviedb.org/3/discover/movie?api_key=96cfbe0ba15c4721bca8030e8e32becb"
        AF.request(urlSerchingMovie).responseDecodable(of: MoviesData.self) { response in
            
            switch response.result {
            case .success(let allMoviesData):
                let moviNames = allMoviesData.results ?? []
                for name in moviNames {
                    self.arrayOfMovies.append(name.title ?? "")
                }
                self.moviesTbleView.reloadData()
            case .failure(let error):
                print("\(error) Movies!")
            }
        }
    }
}






