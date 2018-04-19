//
//  FutureEmptyEvent.swift
//  CoreEvents
//
//  Created by Alexander Kravchenkov on 13.04.2018.
//  Copyright © 2018 Alexander Kravchenkov. All rights reserved.
//

/// Future event is like Future time in English.
///
/// This event emits **only** new messages.
/// It's classic behaviour for event.
open class FutureEmptyEvent: EmptyEvent {

    public typealias Lambda = () -> Void

    private var listners: [Lambda]

    public override init() {
        self.listners = [Lambda]()
        super.init()
    }

    open override func addListner(_ listner: @escaping Lambda) {
        self.listners.append(listner)
    }

    open override func invoke() {
        self.listners.forEach({ $0() })
    }

    open override func clear() {
        self.listners.removeAll()
    }
}
