//
//  WatchLaterTableViewController.swift
//  The Movie Database
//
//  Created by Pavel Shabliy on 01.03.2023.
//

import UIKit
import RealmSwift

class WatchLaterTableViewController: UIViewController {
    
    @IBOutlet weak var watchLaterTableView: UITableView!
    
    //MARK: добавляем сам Realm
    let realm = try? Realm()
    
    //MARK: хранилище данных для Realm
    var moviesResults = [SaveList]()
    
    var arrayOfSavedMediaName = [String]()
    var arrayOfSavedOverview = [String]()
    var arrayOfSavedPopularity = [Double]()
    var arrayOfSavedPosters = [String]()
    var arrayOfSavedId = [Int]()
    var arrayOfSegmentedController = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.setTabBarHidden(false, animated: true)
        self.moviesResults = self.getFromRealm()
        configureUISaved()
        getData()
        watchLaterTableView.reloadData()
    }
    
    func getFromRealm() -> [SaveList] {
        var mediaData = [SaveList]()
        guard let mediaResults = realm?.objects(SaveList.self) else {
            return []
        }
        
        for media in mediaResults {
            mediaData.append(media)
        }
        return mediaData
    }
    
    func getData() {
        arrayOfSavedId = []
        arrayOfSavedPosters = []
        arrayOfSavedOverview = []
        arrayOfSavedPopularity = []
        arrayOfSavedMediaName = []
        arrayOfSegmentedController = []
        
        for data in moviesResults {
            arrayOfSavedId.append(data.idMedia)
            arrayOfSavedPosters.append(data.mediaPoster)
            arrayOfSavedOverview.append(data.mediaOverview)
            arrayOfSavedPopularity.append(data.mediaPopularity)
            arrayOfSavedMediaName.append(data.mediaName)
            arrayOfSegmentedController.append(data.mediaSegmentedController)
        }
    }
    
    func configureUISaved() {
        let nib = UINib(nibName: "MediaTableViewCell", bundle: nil)
        watchLaterTableView.register(nib, forCellReuseIdentifier: "MediaTableViewCell")
    }
}
