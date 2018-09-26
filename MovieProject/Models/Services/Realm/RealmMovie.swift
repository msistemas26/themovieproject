//
//  RealmMovie.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/26/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import Foundation
import RealmSwift

class RealmMovie: Object
{
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var overview = ""
    @objc dynamic var poster_path = ""
    @objc dynamic var release_date = ""
    @objc dynamic var popularity = 0.0
    @objc dynamic var vote_average = 0.0
    @objc dynamic var video = false
    @objc dynamic var category = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
