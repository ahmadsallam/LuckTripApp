//
//  Result.swift
//  LuckyTripApp
//
//  Created by Ahmad Sallam on 17/08/2022.
//

import Foundation

public enum Result<Value> {

    case success(Value)
    case failure(Error)
}

// MARK: - Helpers

extension Result {

    public var isSuccess: Bool {

        switch self {
        case .success:
            return true
        default:
            return false
        }
    }

    /// Wrapped value if result is success, nil otherwise.
    public var value: Value? {

        switch self {
        case .success(let value):
            return value
        default:
            return nil
        }
    }

    /// Wrapped error if result is failure, nil otherwise
    public var error: Error? {

        switch self {
        case .failure(let error):
            return error
        default:
            return nil
        }
    }

}
