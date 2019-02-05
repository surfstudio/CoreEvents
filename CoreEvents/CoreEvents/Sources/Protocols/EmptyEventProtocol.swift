//
//  EmptyEvent.swift
//  CoreEvents
//
//  Created by Alexander Kravchenkov on 13.04.2018.
//  Copyright © 2018 Alexander Kravchenkov. All rights reserved.
//

/// Like classic event, but provide syntactic sugar for emit Void.
public protocol EmptyEventProtocol {

    typealias Lambda = () -> Void

    /// Add new listner.
    ///
    /// - Parameter listner: New listner.
    func addListner(_ listner: @escaping Lambda)

    /// Notify all listners.
    func invoke()

    /// Remove all listners.
    func clear()
}

/// Just type erasure for `EmptyEvent`
open class EmptyEvent: EmptyEventProtocol {

    public init() { }

    open func addListner(_ listner: @escaping Lambda) {
        fatalError("\(#function) should be overriden in child class")
    }

    open func invoke() {
        fatalError("\(#function) should be overriden in child class")
    }

    open func clear() {
        fatalError("\(#function) should be overriden in child class")
    }

    public static func += (left: EmptyEvent, right: Lambda?) {
        guard let right = right else {
            return
        }
        left.addListner(right)
    }

    public static func += (left: EmptyEvent, right: EmptyEvent?) {
        guard let guardedRight = right else {
            return
        }

        left.addListner {
            guardedRight.invoke()
        }
    }
}
