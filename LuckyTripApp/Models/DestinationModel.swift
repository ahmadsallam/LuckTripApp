//
//  DestinationModel.swift
//  LuckyTripApp
//
//  Created by Ahmad Sallam on 17/08/2022.
//

import Foundation

struct Destinations: Codable {
    var destinations: [DestinationModel]
}

struct DestinationModel: Codable {
    
    var id: Int
    var city: String
    var countryName: String
    var thumbnail: Thumbnail
    var destinationVideo: DestinationVideo?
    
    enum CodingKeys: String, CodingKey {
        case id
        case city
        case countryName = "country_name"
        case thumbnail
        case destinationVideo = "destination_video"
    }
}

struct DestinationVideo: Codable {
    
    var url: String?
    var thumbnail: Thumbnail?
}

struct Thumbnail: Codable {
    
    var imageType: String?
    var imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case imageType = "image_type"
        case imageUrl = "image_url"
    }
}
