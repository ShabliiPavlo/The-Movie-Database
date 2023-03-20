//
//  SaveList.swift
//  The Movie Database
//
//  Created by Pavel Shabliy on 09.03.2023.
//

import Foundation
import RealmSwift

class SaveList: Object {
    @objc dynamic var mediaName = ""
    @objc dynamic var mediaPoster = ""
    @objc dynamic var mediaOverview = ""
    @objc dynamic var mediaPopularity = 0.0
    @objc dynamic var idMedia = 0
    @objc dynamic var mediaSegmentedController = ""
}
