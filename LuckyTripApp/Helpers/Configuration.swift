//
//  Configuration.swift
//  LuckyTripApp
//
//  Created by Ahmad Sallam on 17/08/2022.
//

import Foundation

struct Configuration {
    
    enum KeyPath {
        static let apiURL = "API_URL"
        static let infoPlist = "Info"
        static let appConfig = "APP_CONFIG"
    }
    
    static let shared = Configuration()
    
    let apiURL: String
    
    private init(){
        guard let path = Bundle.main.path(forResource: KeyPath.infoPlist, ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: path) as? [AnyHashable: Any],
              let config = plist[KeyPath.appConfig] as? [AnyHashable: String] else {
            fatalError()
        }
        
        apiURL = config[KeyPath.apiURL] ?? ""
    }
    
}
