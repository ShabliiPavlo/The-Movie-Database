//
//  DetailViewController.swift
//  The Movie Database
//
//  Created by Pavel Shabliy on 01.03.2023.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var mediaTitle: UILabel!
    
    @IBOutlet weak var mediaPoster: UIImageView!
    
    @IBOutlet weak var mediaOverview: UILabel!
    
    @IBOutlet weak var mediaPopularity: UILabel!
    
    // MARCK - буферные переменные для отобраения данных о фильмах
    var movieName = ""
    var moviePoster = ""
    var movieOverview = ""
    var moviePopularity = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARCK - отображение данных о фильмах в сториборде
        
        mediaOverview.numberOfLines = 0
        mediaTitle.text = movieName
        
        let posterURL = URL(
            string: "https://image.tmdb.org/t/p/w500\(moviePoster)")
        mediaPoster.sd_setImage(with: posterURL)
        mediaOverview.text = movieOverview
        mediaPopularity.text = "Popularity: \(String(moviePopularity))"
    }
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        
    }
    
}
