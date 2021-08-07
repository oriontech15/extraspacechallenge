//
//  PhotoModel.swift
//  ExtraSpaceChallenge
//
//  Created by orion on 8/6/21.
//

import Foundation

struct Photo: Codable {
    
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
    
}
