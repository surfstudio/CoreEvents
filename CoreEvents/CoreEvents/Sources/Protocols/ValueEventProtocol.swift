//
//  ValueEvent.swift
//  CoreEvents
//
//  Created by Alexander Kravchenkov on 13.04.2018.
//  Copyright © 2018 Alexander Kravchenkov. All rights reserved.
//

/// This event requires each listener return any value after handling.
///
/// This event may contains only one listner.
///
/// It may be cool for using instead of classic delegating approach.
public protocol ValueEventProtocol {

    associatedtype Input
    associatedtype Output

    typealias Lambda = (Input) -> (Output)

    var valueListner: Lambda? { get set }
}

/// Just type erasure for `ValueEventProtocol`
open class ValueEvent<Input, Output>: ValueEventProtocol {

    public init() { }

    open var valueListner: ((Input) -> (Output))? {
        get { fatalError("\(#function) should be overriden in child class") }
        set { fatalError("\(#function) should be overriden in child class") }
    }
}
