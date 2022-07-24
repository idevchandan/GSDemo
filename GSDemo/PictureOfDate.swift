//
//  PictureOfDate.swift
//  GSDemo
//
//  Created by Chandan Kumar on 24/07/22.
//

import Foundation

struct PictureOfDate: Codable{
    
    var title : String?
    var date : String?
    var details : String?
    var imageUrl : String?
    
    enum CodingKeys : String, CodingKey {
        case title = "title"
        case date = "date"
        case details = "explanation"
        case imageUrl = "url"
    }
}
