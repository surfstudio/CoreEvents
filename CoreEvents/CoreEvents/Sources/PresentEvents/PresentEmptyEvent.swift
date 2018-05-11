//
//  PresentEmptyEvent.swift
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
open class PresentEmptyEvent: EmptyEvent {

    public typealias Lambda = () -> Void

    private var listners: [Lambda]
    private var didEmits: Bool

    public override init() {
        self.listners = []
        self.didEmits = false
        super.init()
    }

    /// Add new listner and emits last emited message only for this listner.
    ///
    /// - Parameter listner: New listner.
    open override func addListner(_ listner: @escaping Lambda) {
        if self.didEmits {
            listner()
        }
        self.listners.append(listner)
    }

    /// Notify all listners.
    open override func invoke() {
        self.didEmits = true
        self.listners.forEach({ $0() })
    }

    /// Remove all listners and erase last emited value
    open override func clear() {
        self.didEmits = false
        self.listners.removeAll()
    }

    /// Remove last emited value.
    open func eraseLastEmited() {
        self.didEmits = false
    }
}
