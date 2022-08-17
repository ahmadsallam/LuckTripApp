//
//  BaseRequest.swift
//  LuckyTripApp
//
//  Created by Ahmad Sallam on 17/08/2022.
//

import Foundation
import Alamofire

public protocol Request {
    var path: String { get }
    var methods: HTTPMethod { get }
}

protocol BaseRequest: Request {}

extension BaseRequest {
    var host: String? {
        String.init(format: "%@", Configuration.shared.apiURL)
    }
}
