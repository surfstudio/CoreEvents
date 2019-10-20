//
//  FutureEvent.swift
//  CoreEvents
//
//  Created by Alexander Kravchenkov on 13.04.2018.
//  Copyright © 2018 Alexander Kravchenkov. All rights reserved.
//

/// Это обыкновенное событие, которое не хранит предыдущих сообщений.
///
/// - SeeAlso: `Event`
open class FutureEvent<Input>: Event<Input> {

    public typealias Closure = (Input) -> Void

    private var listeners: [String: Closure]

    public override init() {
        self.listeners = [:]
        super.init()
    }

    open override func add(key: String = #file, _ listener: @escaping Closure) {
        self.listeners[key] = listener
    }

    open override func invoke(with input: Input) {
        self.listeners.keys.forEach { self.invoke(with: input, key: $0) }
    }

    open override func invoke(with input: Input, key: String = #file) {
        self.listeners[key]?(input)
    }

    open override func clear() {
        self.listeners.removeAll()
    }

    open override func remove(key: String = #file) {
        self.listeners.removeValue(forKey: key)
    }
}
