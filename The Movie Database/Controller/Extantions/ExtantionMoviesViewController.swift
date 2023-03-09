//
//  ExtantionMoviesViewController.swift
//  The Movie Database
//
//  Created by Pavel Shabliy on 01.03.2023.
//

import UIKit
import Alamofire

extension MoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        // MARCK - пушим данные про фильмы
        let moviesNames = arrayOfMovies[indexPath.row]
        let moviesPosters = arrayOfPosters[indexPath.row]
        let moviesOverview = arrayOfOverview[indexPath.row]
        let moviesPopularity = arrayOfPopularity[indexPath.row]
        
        if let detailViewController = main.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            
            detailViewController.movieName = moviesNames
            detailViewController.moviePoster = moviesPosters
            detailViewController.movieOverview = moviesOverview
            detailViewController.moviePopularity = moviesPopularity
            
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

//MARCK - задаем колличествоячеек и названия фильмов для таблици
extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var filmTitle = arrayOfMovies[indexPath.row]
        cell.textLabel?.text = filmTitle
        return cell
    }
}

extension MoviesViewController: UISearchBarDelegate {
    
    // Метод, вызывающийся при изменении текста в поисковой строке
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // Сброс таймера
        searchTimer?.invalidate()
        
        // Сохраняем текст запроса
        lastSearchText = searchText
        
        // Запускаем таймер для задержки поиска
        searchTimer = Timer.scheduledTimer(withTimeInterval: searchDelay, repeats: false, block: { [weak self] _ in
            
            // Проверяем, что текст запроса изменился за время задержки
            guard let self = self, self.lastSearchText == searchText else {
                self?.arrayOfMovies = []
                self?.arrayOfOverview = []
                self?.arrayOfPopularity = []
                self?.arrayOfPosters = []
                self?.moviesTbleView.reloadData()
                self?.getMoviesTitle()
                return
            }
            
            // Выполняем поиск
            self.searchMovies()
        })
    }
    
    // Метод, выполняющий поиск фильмов
    func searchMovies() {
        let urlSearch: String
        if segmentedController == "movie" {
            urlSearch = "https://api.themoviedb.org/3/search/movie?api_key=96cfbe0ba15c4721bca8030e8e32becb&query=\(lastSearchText)"
        } else {
            urlSearch = "https://api.themoviedb.org/3/search/tv?api_key=96cfbe0ba15c4721bca8030e8e32becb&query=\(lastSearchText)"
        }
        
        AF.request(urlSearch).responseDecodable(of: MoviesData.self) { response in
            switch response.result {
            case .success(let allMoviesData):
                let moviNames = allMoviesData.results ?? []
                self.arrayOfMovies = []
                self.arrayOfOverview = []
                self.arrayOfPopularity = []
                self.arrayOfPosters = []
                for name in moviNames {
                    if self.segmentedController == "movie" {
                        self.arrayOfMovies.append(name.title ?? "")
                    } else {
                        self.arrayOfMovies.append(name.name ?? "")
                    }
                    self.arrayOfOverview.append(name.overview ?? "")
                    self.arrayOfPopularity.append(name.popularity ?? 0.0)
                    self.arrayOfPosters.append(name.poster_path ?? "")
                }
                self.moviesTbleView.reloadData()
            case .failure(let error):
                print("\(error) Movies!")
            }
        }
    }
}
