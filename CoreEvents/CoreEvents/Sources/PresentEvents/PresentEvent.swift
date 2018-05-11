//
//  PresentEvent.swift
//  CoreEvents
//
//  Created by Alexander Kravchenkov on 13.04.2018.
//  Copyright © 2018 Alexander Kravchenkov. All rights reserved.
//

/// Present event is like Present time in English.
///
/// This event emits **last old emited value and all new messages**.
///
/// Provides `+=` operation for adding new listners: `event += { value in ... }`
///
/// `Input` - it's a type of value this event will emit.
open class PresentEvent<Input>: Event<Input> {

    public typealias Lambda = (Input) -> Void

    private var listners: [Lambda]
    private var lastEmitedMessage: Input?

    public override init() {
        self.listners = []
        super.init()
    }

    /// Add new listner and emits last emited message only for this listner.
    ///
    /// - Parameter listner: New listner.
    open override func addListner(_ listner: @escaping Lambda) {
        if let guardedLastRecived = self.lastEmitedMessage {
            listner(guardedLastRecived)
        }
        self.listners.append(listner)
    }

    /// Notify all listners.
    ///
    /// - Parameter input: Data for listners.
    open override func invoke(with input: Input) {
        self.lastEmitedMessage = input
        self.listners.forEach({ $0(input) })
    }

    /// Remove all listners and erase last emited value
    open override func clear() {
        self.lastEmitedMessage = nil
        self.listners.removeAll()
    }

    /// Remove last emited value.
    open func eraseLastEmited() {
        self.lastEmitedMessage = nil
    }
}
