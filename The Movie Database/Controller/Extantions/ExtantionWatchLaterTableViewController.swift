//
//  ExtantionWatchLaterTableViewController.swift
//  The Movie Database
//
//  Created by Pavel Shabliy on 01.03.2023.
//

import UIKit

extension WatchLaterTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        let moviesNames = arrayOfSavedMediaName[indexPath.row]
        let moviesPosters = arrayOfSavedPosters[indexPath.row]
        let moviesOverview = arrayOfSavedOverview[indexPath.row]
        let moviesPopularity = arrayOfSavedPopularity[indexPath.row]
        let id = arrayOfSavedId[indexPath.row]
        let segmentedController = arrayOfSegmentedController[indexPath.row]
        
        if let detailViewController = main.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            
            detailViewController.movieName = moviesNames
            detailViewController.moviePoster = moviesPosters
            detailViewController.movieOverview = moviesOverview
            detailViewController.moviePopularity = moviesPopularity
            detailViewController.mediaId = id
            detailViewController.segmentedController = segmentedController
            
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

extension WatchLaterTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = watchLaterTableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell") as? MediaTableViewCell else { return UITableViewCell()}
        
        let filmSavedTitle = arrayOfSavedMediaName[indexPath.row]
        let posterSavedPath = arrayOfSavedPosters[indexPath.row]
        let sevedPopularity = arrayOfSavedPopularity[indexPath.row]
        
        cell.configureWith(nameOrTitle: filmSavedTitle,
                           posterPath: posterSavedPath,
                           popularity: sevedPopularity)
        
        return cell
    }
    // Удаление из реалма и списка посмотреть позже
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        try! realm?.write {
            
            realm?.delete(moviesResults[indexPath.row])
        }
        
        if editingStyle == .delete {
            
            moviesResults.remove(at: indexPath.row)
            watchLaterTableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
}


