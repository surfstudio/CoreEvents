//
//  Event.swift
//  EventKit
//
//  Created by Alexander Kravchenkov on 13.04.2018.
//  Copyright © 2018 Alexander Kravchenkov. All rights reserved.
//

/// Classic typesafe event.
public protocol Event {

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
