//
//  NetworkError.swift
//  LuckyTripApp
//
//  Created by Ahmad Sallam on 17/08/2022.
//

import Foundation

public enum NetworkError: Error {
    
    case invalidJSONMapping
    case business(title: String, message: String,errorType: String)
}
