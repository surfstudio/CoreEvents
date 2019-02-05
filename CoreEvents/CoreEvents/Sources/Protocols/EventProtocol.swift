//
//  Event.swift
//  CoreEvents
//
//  Created by Alexander Kravchenkov on 13.04.2018.
//  Copyright © 2018 Alexander Kravchenkov. All rights reserved.
//

/// Classic typesafe event.
public protocol EventProtocol {

    associatedtype Input
    typealias Lambda = (Input) -> Void

    /// Add new listner.
    ///
    /// - Parameter listner: New listner.
    func addListner(_ listner: @escaping Lambda)

    /// Notify all listners.
    ///
    /// - Parameter input: Data for listners.
    func invoke(with input: Input)

    /// Remove all listners.
    func clear()
}

/// Just type erasure for `EventProtocol`
open class Event<Input>: EventProtocol {

    public init() { }

    open func addListner(_ listner: @escaping Lambda) {
        fatalError("\(#function) should be overriden in child class")
    }

    open func invoke(with input: Input) {
        fatalError("\(#function) should be overriden in child class")
    }

    open func clear() {
        fatalError("\(#function) should be overriden in child class")
    }

    public static func += (left: Event<Input>, right: Lambda?) {
        guard let right = right else {
            return
        }
        left.addListner(right)
    }

    public static func += (left: Event<Input>, right: Event<Input>?) {
        guard let guardedRight = right else {
            return
        }

        left.addListner { input in
            guardedRight.invoke(with: input)
        }
    }
}
