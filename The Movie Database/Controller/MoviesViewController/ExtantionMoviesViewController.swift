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
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        // MARK: пушим данные про фильмы
        let moviesNames = arrayOfMediaName[indexPath.row]
        let moviesPosters = arrayOfPosters[indexPath.row]
        let moviesOverview = arrayOfOverview[indexPath.row]
        let moviesPopularity = arrayOfPopularity[indexPath.row]
        let id = arrayOfId[indexPath.row]
        let segmentedController = segmentedController
        
        if let detailViewController = main.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            
            detailViewController.movieName = moviesNames
            detailViewController.moviePoster = moviesPosters
            detailViewController.movieOverview = moviesOverview
            detailViewController.moviePopularity = moviesPopularity
            detailViewController.mediaId = id
            detailViewController.segmentedController = segmentedController
            
            navigationController?.pushViewController(detailViewController,
                                                     animated: true)
        }
    }
}

//MARK: задаем колличествоячеек и названия фильмов для таблици
extension MoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfMediaName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = moviesTbleView.dequeueReusableCell(withIdentifier: "MediaTableViewCell") as? MediaTableViewCell else { return UITableViewCell()}
        
        //MARK: данные отображающиеся в ячейке
        let filmTitle = arrayOfMediaName[indexPath.row]
        let posterPath = arrayOfPosters[indexPath.row]
        let popularity = arrayOfPopularity[indexPath.row]
        
        cell.configureWith(nameOrTitle: filmTitle,
                           posterPath: posterPath,
                           popularity: popularity)
        return cell
    }
}

extension MoviesViewController: UISearchBarDelegate {
    
    //MARK: метод, вызывающийся при изменении текста в поисковой строке
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //MARK: сброс таймера
        searchTimer?.invalidate()
        
        //MARK: сохраняем текст запроса
        lastSearchText = searchText
        
        //MARK: запускаем таймер для задержки поиска
        searchTimer = Timer.scheduledTimer(withTimeInterval: searchDelay, repeats: false, block: { [weak self] _ in
            
            //MARK: проверяем, что текст запроса изменился за время задержки
            guard let self = self, self.lastSearchText == searchText else {
                self?.arrayOfMediaName = []
                self?.arrayOfOverview = []
                self?.arrayOfPopularity = []
                self?.arrayOfPosters = []
                self?.moviesTbleView.reloadData()
                self?.getMoviesData()
                return
            }
            //MARK: выполняем поиск
            self.searchMovies()
        })
    }
    
    //MARK: метод, выполняющий поиск фильмов
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
                self.arrayOfMediaName = []
                self.arrayOfOverview = []
                self.arrayOfPopularity = []
                self.arrayOfPosters = []
                self.arrayOfId = []
                for name in moviNames {
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
}
