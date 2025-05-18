//
//  Observable.swift
//  SpaceTest
//
//  Created by M1 Pro on 18.05.2025.
//

import Foundation

final class Observable<T> {
    
    typealias Listener = (T) -> Void
    
    private var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(listener: Listener?, andFire: Bool = false) {
        self.listener = listener
        
        if andFire {
            listener?(value)
        }
    }
}
