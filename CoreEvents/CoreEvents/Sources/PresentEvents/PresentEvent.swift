//
//  PresentEvent.swift
//  CoreEvents
//
//  Created by Alexander Kravchenkov on 13.04.2018.
//  Copyright © 2018 Alexander Kravchenkov. All rights reserved.
//

/// Это событие запоминает последнее сообщение,
/// которое было отправлено подписчикам и в случае добавления нового подписчика
/// cразу отправляет ему это сообщение.
///
/// Этот тип событий можно использовать для того, чтобы оповещать подписчиков после того, как сообщение было послано.
///
/// - SeeAlso: `Event`
open class PresentEvent<Input>: Event<Input> {

    public typealias Closure = (Input) -> Void

    private var listeners: [String: Closure]
    private var lastEmitedMessage: Input?

    public override init() {
        self.listeners = [:]
        super.init()
    }

    /// Добавляет нового слушателя и если есть запомненное сообщение, то сразу оповещает подписчика.
    ///
    /// - SeeAlso: `Event.add`
    open override func add(key: String = #file, _ listener: @escaping Closure) {
        if let guardedLastRecived = self.lastEmitedMessage {
            listener(guardedLastRecived)
        }
        self.listeners[key] = listener
    }

    /// Оповещает всех слушателей.
    /// Запоминает сообщение.
    ///
    /// - SeeAlso: `Event.invoke(with input: Input)`
    open override func invoke(with input: Input) {
        self.listeners.keys.forEach { self.invoke(with: input, key: $0) }
    }

    /// Оповещает конкретного подписчика.
    /// Запоминает сообщение
    ///
    /// - SeeAlso: `Event.invoke(with input: Input, by key: String)`
    open override func invoke(with input: Input, key: String = #file) {
        self.lastEmitedMessage = input
        self.listeners[key]?(input)
    }

    /// Удаляет всех подписчиков.
    /// В том числе удаляет последнее запомненное сообщение.
    ///
    /// - SeeAlso: `Event.clear`
    open override func clear() {
        self.lastEmitedMessage = nil
        self.listeners.removeAll()
    }

    open override func remove(key: String = #file) {
        self.listeners.removeValue(forKey: key)
    }

    /// Удаляет последнее заполненное сообщение.
    open func eraseLastEmited() {
        self.lastEmitedMessage = nil
    }
}
