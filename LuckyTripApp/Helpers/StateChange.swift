//
//  StateChange.swift
//  LuckyTripApp
//
//  Created by Ahmad Sallam on 17/08/2022.
//

import Foundation

public protocol StateChnage {}

public protocol ViewMode {}

open class BaseViewModel: NSObject, ViewMode {
    public override init() {
        
    }
}

open class StatefulViewModel<SC: StateChnage>: BaseViewModel {
    
    public typealias StateChangeHandler = ((SC) -> Void)
    private var stateChangeHandler: [String: StateChangeHandler] = [:]
    
    public final func addChangeHandler(id:String? = nil, handler: @escaping StateChangeHandler) {
        stateChangeHandler[id ?? ""] = handler
    }
    
    public final func emit(change: SC) {
        stateChangeHandler.values.forEach({(handler: StateChangeHandler) in
            handler(change)
        })
    }
    
}
