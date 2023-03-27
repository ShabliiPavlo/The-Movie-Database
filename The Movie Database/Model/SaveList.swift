//
//  SaveList.swift
//  The Movie Database
//
//  Created by Pavel Shabliy on 09.03.2023.
//

import Foundation
import RealmSwift

class SaveList: Object {
    @Persisted var mediaName = ""
    @Persisted var mediaPoster = ""
    @Persisted var mediaOverview = ""
    @Persisted var mediaPopularity = 0.0
    @Persisted(primaryKey: true) var idMedia = 0
    @Persisted var mediaSegmentedController = ""
}
