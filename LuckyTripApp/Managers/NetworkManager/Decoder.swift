//
//  Decoder.swift
//  LuckyTripApp
//
//  Created by Ahmad Sallam on 17/08/2022.
//

import Foundation

final class Decoder<T: Codable> {
    enum JSONType {
        case codable
    }

    static func decode(data: Data?, jsonType: JSONType = .codable) throws -> (T) {
        guard let data = data else { throw NetworkError.invalidJSONMapping }

        do {
            switch jsonType {
            case .codable:

                let decodedModel = try JSONDecoder().decode(T.self, from: data)
                return (decodedModel)
            }

        } catch let returnedError {
            #if DEBUG
            let astrixStart = "🚨🚨🚨🚨🚨🚨🚨 DECODING ISSUE Start 🚨🚨🚨🚨🚨🚨🚨 \n"
            let type = "\(T.self)"
            let area = String(format: "Type: %@ \n", type)
            let err: Error? = returnedError
            let debuggedError = String(format: "Error: %@ \n", err.debugDescription)
            let astrixEnd = "🚨🚨🚨🚨🚨🚨🚨 DECODING ISSUE End 🚨🚨🚨🚨🚨🚨🚨 \n"
            debugPrint(astrixStart, area, debuggedError, astrixEnd)
            #endif
            throw NetworkError.invalidJSONMapping
        }
    }
}
