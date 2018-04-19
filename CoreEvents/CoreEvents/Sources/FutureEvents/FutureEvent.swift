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
open class FutureEvent<Input>: Event<Input> {

    public typealias Lambda = (Input) -> Void

    private var listners: [Lambda]

    public override init() {
        self.listners = []
        super.init()
    }
    
    /// Add new listner.
    ///
    /// - Parameter listner: New listner.
    open override func addListner(_ listner: @escaping Lambda) {
        self.listners.append(listner)
    }

    /// Notify all listners.
    ///
    /// - Parameter input: Data for listners.
    open override func invoke(with input: Input) {
        self.listners.forEach({ $0(input) })
    }

    /// Remove all listners.
    open override func clear() {
        self.listners.removeAll()
    }
}
