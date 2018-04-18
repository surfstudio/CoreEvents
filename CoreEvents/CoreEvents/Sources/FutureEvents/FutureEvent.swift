//
//  FutureEvent.swift
//  CoreEvents
//
//  Created by Alexander Kravchenkov on 13.04.2018.
//  Copyright © 2018 Alexander Kravchenkov. All rights reserved.
//

/// Future event is like Future time in English.
///
/// This event emits **only** new messages.
/// It's classic behaviour for event.
///
/// Provides `+=` operation for adding new listners: `event += { value in ... }`
///
/// `Input` - it's a type of value this event will emit.
public class FutureEvent<Input>: Event {

    public typealias Lambda = (Input) -> Void

    private var listners: [Lambda]

    public init() {
        self.listners = []
    }
    
    /// Add new listner.
    ///
    /// - Parameter listner: New listner.
    public func addListner(_ listner: @escaping Lambda) {
        self.listners.append(listner)
    }

    /// Notify all listners.
    ///
    /// - Parameter input: Data for listners.
    public func invoke(with input: Input) {
        self.listners.forEach({ $0(input) })
    }

    /// Remove all listners.
    public func clear() {
        self.listners.removeAll()
    }
}

// MARK: - Operations

extension FutureEvent {
    public static func += (left: FutureEvent<Input>, right: @escaping Lambda) {
        left.addListner(right)
    }
}
