//
//  ValueEvent.swift
//  EventsKit
//
//  Created by Alexander Kravchenkov on 13.04.2018.
//  Copyright © 2018 Alexander Kravchenkov. All rights reserved.
//

/// This event requires each listener return any value after handling.
///
/// This event may contains only one listner.
///
/// It may be cool for using instead of classic delegating approach.
public protocol ValueEvent {

    associatedtype Input
    associatedtype Return

    typealias Lambda = (Input) -> (Return)

    var valueListner: Lambda? { get set }
}
