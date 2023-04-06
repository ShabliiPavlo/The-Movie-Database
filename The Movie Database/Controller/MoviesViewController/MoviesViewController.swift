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
    
    //MARK: переключатель с фильмов на сериалы
    var segmentedController = "movie"
    
    //MARK: таймер для задержки поискового запроса
    var searchTimer: Timer?
    
    //MARK: последний текст запроса
    var lastSearchText = ""
    
    //MARK: задержка поиска
    let searchDelay: TimeInterval = 1.0
    
    var arrayOfMediaName = [String]()
    var arrayOfOverview = [String]()
    var arrayOfPopularity = [Double]()
    var arrayOfPosters = [String]()
    var arrayOfId = [Int]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField
        {
            textField.textColor = UIColor.white
        }
        tabBarController?.setTabBarHidden(false, animated: true)
        configureUI()
        getMoviesData()
    }
    
    //MARK: данные названия фильмов в таблицу .reloadData() и парсим данные для подготовленных масивов
    func getMoviesData() {
        let urlSerchingMovie = "https://api.themoviedb.org/3/discover/\(segmentedController)?api_key=96cfbe0ba15c4721bca8030e8e32becb"
        AF.request(urlSerchingMovie).responseDecodable(of: MoviesData.self)
        { response in
            
            switch response.result {
            case .success(let allMoviesData):
                let mediaData = allMoviesData.results ?? []
                for name in mediaData {
                    if self.segmentedController == "movie" {
                        self.arrayOfMediaName.append(name.title ?? "")
                    } else {
                        self.arrayOfMediaName.append(name.name ?? "")
                    }
                    self.arrayOfOverview.append(name.overview ?? "")
                    self.arrayOfPopularity.append(name.popularity ?? 0.0)
                    self.arrayOfPosters.append(name.poster_path ?? "")
                    self.arrayOfId.append(name.id ?? 0)
                }
                self.moviesTbleView.reloadData()
            case .failure(let error):
                print("\(error) Movies!")
            }
        }
    }
    
    @IBAction func segmantedControlValueChanged(_ sender: UISegmentedControl)
    {
        if sender.selectedSegmentIndex == 0 {
            segmentedController = "movie"
        } else {
            segmentedController = "tv"
        }
        arrayOfId = []
        arrayOfMediaName = []
        arrayOfOverview = []
        arrayOfPopularity = []
        arrayOfPosters = []
        moviesTbleView.reloadData()
        getMoviesData()
    }
    
    //MARK: создаем ниб 
    func configureUI()
    {
        let nib = UINib(nibName: "MediaTableViewCell", bundle: nil)
        moviesTbleView.register(nib, forCellReuseIdentifier: "MediaTableViewCell")
    }
}





