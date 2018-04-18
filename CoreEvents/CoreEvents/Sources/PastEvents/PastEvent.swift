//
//  PastEvent.swift
//  CoreEvents
//
//  Created by Alexander Kravchenkov on 13.04.2018.
//  Copyright © 2018 Alexander Kravchenkov. All rights reserved.
//

/// Present event is like Past time in English.
///
/// This event emits **all old emited value and all new messages**.
///
/// Provides `+=` operation for adding new listners: `event += { value in ... }`
///
/// `Input` - it's a type of value this event will emit.
class PastEvent<Input>: Event {

    public typealias Lambda = (Input) -> Void

    private var listners: [Lambda]
    private var laterEmits: [Input]

    public init() {
        self.laterEmits = [Input]()
        self.listners = []
    }

    /// Add new listner and emits last emited message only for this listner.
    ///
    /// - Parameter listner: New listner.
    public func addListner(_ listner: @escaping Lambda) {
        if !self.laterEmits.isEmpty {
            self.laterEmits.forEach { listner($0) }
        }
        self.listners.append(listner)
    }

    /// Notify all listners.
    ///
    /// - Parameter input: Data for listners.
    public func invoke(with input: Input) {
        self.laterEmits.append(input)
        self.listners.forEach({ $0(input) })
    }

    /// Remove all listners and erase last emited value
    public func clear() {
        self.laterEmits.removeAll()
        self.listners.removeAll()
    }
}

// MARK: - Operations

extension PastEvent {
    public static func += (left: PastEvent<Input>, right: @escaping Lambda) {
        left.addListner(right)
    }
}
