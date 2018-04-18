//
//  FutureValueEvent.swift
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
///
/// `Return` - it's a type of value which listner should return after handling.
open class FutureValueEvent<Input, Output>: ValueEvent<Input, Output> {
    public typealias Lambda = (Input) -> (Output)

    private var valueListnerData: Lambda?

    open override var valueListner: Lambda? {
        get {
            return self.valueListnerData
        }
        set {
            self.valueListnerData = newValue
        }
    }
}
