//
//  DestReq.swift
//  LuckyTripApp
//
//  Created by Ahmad Sallam on 17/08/2022.
//

import Foundation
import Alamofire

struct DestinationsRequest: BaseRequest {
    var path: String = "destinations"
    var methods: HTTPMethod = .get
}
