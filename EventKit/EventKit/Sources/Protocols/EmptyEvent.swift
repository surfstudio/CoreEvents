//
//  EmptyEvent.swift
//  EventKit
//
//  Created by Alexander Kravchenkov on 13.04.2018.
//  Copyright © 2018 Alexander Kravchenkov. All rights reserved.
//

/// Like classick event, but provide syntactic sugar for emit Void
public protocol EmptyEvent {

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
