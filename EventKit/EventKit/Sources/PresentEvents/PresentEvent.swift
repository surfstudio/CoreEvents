//
//  PresentEvent.swift
//  EventKit
//
//  Created by Alexander Kravchenkov on 13.04.2018.
//  Copyright © 2018 Alexander Kravchenkov. All rights reserved.
//

/// Present event is like Present time in English.
/// This event emits **last old emited value and all new messages**.
/// Provide `+=` operation for adding new listners: `let evet += { value in ... }`
/// `Input` - it's a type of value this event will emit.
public class PresentEvent<Input>: Event {

    public typealias Lambda = (Input) -> Void

    private var listners: [Lambda]
    private var lastRecivedMessage: Input?

    public init() {
        self.listners = []
    }

    /// Add new listner and emits last emited message only for this listner.
    ///
    /// - Parameter listner: New listner.
    public func addListner(_ listner: @escaping Lambda) {
        if let guardedLastRecived = self.lastRecivedMessage {
            listner(guardedLastRecived)
        }
        self.listners.append(listner)
    }

    /// Notify all listners.
    ///
    /// - Parameter input: Data for listners.
    public func invoke(with input: Input) {
        self.lastRecivedMessage = input
        self.listners.forEach({ $0(input) })
    }

    /// Remove all listners.
    public func clear() {
        self.listners.removeAll()
    }
}

// MARK: - Operations

extension PresentEvent {
    public static func += (left: PresentEvent<Input>, right: @escaping Lambda) {
        left.addListner(right)
    }
}
