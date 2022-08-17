//
//  Networking.swift
//  LuckyTripApp
//
//  Created by Ahmad Sallam on 17/08/2022.
//

import Foundation
import Alamofire

extension Networking {
    
    final var additionalHeaders: RequestHeaders {
        
        return [
            "Accept": "application/json"
        ]
    }
}

final class Networking {
    typealias RequestHeaders = [String: String]
    
    static let shared: Networking = Networking()
    var session: Alamofire.Session?
    
    private init() {
        session = Alamofire.Session()
    }
    
}

class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
