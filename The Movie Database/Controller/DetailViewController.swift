//
//  DetailViewController.swift
//  The Movie Database
//
//  Created by Pavel Shabliy on 01.03.2023.
//

import UIKit
import SDWebImage
import youtube_ios_player_helper_swift
import Alamofire
import RealmSwift

class DetailViewController: UIViewController {
    
    @IBOutlet weak var mediaTitle: UILabel!
    @IBOutlet weak var mediaPoster: UIImageView!
    @IBOutlet weak var mediaOverview: UILabel!
    @IBOutlet weak var mediaPopularity: UILabel!
    @IBOutlet weak var youTbubePlayer: YTPlayerView!
    
    // Добавляем сам Realm
    let realm = try? Realm()
    
    // MARK - буферные переменные для отобржения данных о фильмах
    var movieName = ""
    var moviePoster = ""
    var movieOverview = ""
    var moviePopularity = 0.0
    var mediaId = 0
    var segmentedController = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK - отображение данных о фильмах в сториборде
        
        mediaOverview.numberOfLines = 0
        mediaTitle.text = movieName
        
        let posterURL = URL(
            string: "https://image.tmdb.org/t/p/w500\(moviePoster)")
        mediaPoster.sd_setImage(with: posterURL)
        mediaOverview.text = movieOverview
        mediaPopularity.text = "Popularity: \(String(moviePopularity))"
        loadTrailer()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        saveRealm()
    }
    
    func loadTrailer() {
        let url = "https://api.themoviedb.org/3/\(segmentedController)/\(mediaId)/videos?api_key=96cfbe0ba15c4721bca8030e8e32becb&language=en-US"
        AF.request(url).responseDecodable(of:VideoResponce.self) { dataResponse in
            let videos = dataResponse.value?.results
            guard let key = videos?.first?.key else { return }
            self.youTbubePlayer.load(videoId: key)
            self.youTbubePlayer.playVideo()
        }
    }
    
    func saveRealm() {
        let mediaResult = SaveList()
        mediaResult.idMedia = mediaId
        mediaResult.mediaOverview = movieOverview
        mediaResult.mediaName = movieName
        mediaResult.mediaPopularity = moviePopularity
        mediaResult.mediaPoster = moviePoster
        mediaResult.mediaSegmentedController = segmentedController
        try? realm?.write {
            realm?.add(mediaResult)
        }
    }
}
