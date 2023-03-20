//
//  MediaTableViewCell.swift
//  The Movie Database
//
//  Created by Pavel Shabliy on 15.03.2023.
//

import UIKit
import SDWebImage
import RealmSwift

class MediaTableViewCell: UITableViewCell {

    @IBOutlet weak var cellPoster: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    
    // Отображаем данные в ксибе
    func configureWith(nameOrTitle:String, posterPath:String) {
        cellTitle.text = nameOrTitle
        
        let posterURL = URL(
            string: "https://image.tmdb.org/t/p/w500\(posterPath)")
        cellPoster.sd_setImage(with: posterURL)
    }
}
