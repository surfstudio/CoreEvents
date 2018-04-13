//
//  EmptyPresentEvent.swift
//  EventKit
//
//  Created by Alexander Kravchenkov on 13.04.2018.
//  Copyright © 2018 Alexander Kravchenkov. All rights reserved.
//

/// Present event is like Present time in English.
/// This event emits **last old emited value and all new messages**.
/// Provide `+=` operation for adding new listners: `let evet += { value in ... }`
class EmptyPresentEvent: EmptyEvent {

    public typealias Lambda = () -> Void

    private var listners: [Lambda]
    private var didEmits: Bool

    public init() {
        self.listners = []
        self.didEmits = false
    }

    /// Add new listner and emits last emited message only for this listner.
    ///
    /// - Parameter listner: New listner.
    public func addListner(_ listner: @escaping Lambda) {
        if self.didEmits {
            listner()
        }
        self.listners.append(listner)
    }

    /// Notify all listners.
    public func invoke() {
        self.didEmits = true
        self.listners.forEach({ $0() })
    }

    /// Remove all listners and erase last emited value
    public func clear() {
        self.didEmits = false
        self.listners.removeAll()
    }
}

// MARK: - Operations

extension EmptyPresentEvent {
    public static func += (left: EmptyPresentEvent, right: @escaping Lambda) {
        left.addListner(right)
    }
}
