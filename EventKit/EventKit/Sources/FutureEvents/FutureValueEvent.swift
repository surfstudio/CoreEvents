//
//  FutureValueEvent.swift
//  EventKit
//
//  Created by Alexander Kravchenkov on 13.04.2018.
//  Copyright © 2018 Alexander Kravchenkov. All rights reserved.
//

/// Future event is like Future time in English.
/// This event emits **only** new messages.
/// It's classic behaviour for event.
/// Provide `+=` operation for adding new listners: `let evet += { value in ... }`
/// `Input` - it's a type of value this event will emit.
/// `Return` - it's a type of value which listner should return after handling.
class FutureValueEvent<Input, Return>: ValueEvent {
    public typealias Lambda = (Input) -> (Return)

    public var valueListner: Lambda?
}
