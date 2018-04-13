//
//  FutureEmptyEvent.swift
//  EventKit
//
//  Created by Alexander Kravchenkov on 13.04.2018.
//  Copyright © 2018 Alexander Kravchenkov. All rights reserved.
//

/// Future event is like Future time in English.
/// This event emit **only** new messages.
/// It's classic behaviour for event.
public class FutureEmptyEvent: EmptyEvent {

    public typealias Lambda = () -> Void

    private var listners: [Lambda]

    public init() {
        self.listners = [Lambda]()
    }

    public func addListner(_ listner: @escaping Lambda) {
        self.listners.append(listner)
    }

    public func invoke() {
        self.listners.forEach({ $0() })
    }

    public func clear() {
        self.listners.removeAll()
    }
}

extension FutureEmptyEvent {
    public static func += (left: FutureEmptyEvent, right: Lambda?) {
        guard let right = right else {
            return
        }
        left.addListner(right)
    }
}
