//
//  PresentEvent.swift
//  CoreEvents
//
//  Created by Alexander Kravchenkov on 13.04.2018.
//  Copyright © 2018 Alexander Kravchenkov. All rights reserved.
//

/// Это событие запоминает последнее сообщение,
/// которое было отправлено подписчикам и в случае добалвения нового подписчика с
/// разу отправляет ему это сообщение.
///
/// Этот тип событий можно использовать для того, чтобы оповещать подписчиков после того, как сообщение было послано.
///
/// - SeeAlso: `Event`
open class PresentEvent<Input>: Event<Input> {

    public typealias Closure = (Input) -> Void

    private var listners: [String: Closure]
    private var lastEmitedMessage: Input?

    public override init() {
        self.listners = [:]
        super.init()
    }

    /// Добавляет нового слушателя и если есть запомненное сообщение, то сразу оповещает подписчикаю.
    ///
    /// - SeeAlso: `Event.add`
    open override func add(key: String = #file, _ listner: @escaping Closure) {
        if let guardedLastRecived = self.lastEmitedMessage {
            listner(guardedLastRecived)
        }
        self.listners[key] = listner
    }

    /// Оповещает всех слушателей.
    /// Запоминает сообщение.
    ///
    /// - SeeAlso: `Event.invoke(with input: Input)`
    open override func invoke(with input: Input) {
        self.listners.keys.forEach { self.invoke(with: input, key: $0) }
    }

    /// Оповещает конкретного подписчика.
    /// Запоминает сообщение
    ///
    /// - SeeAlso: `Event.invoke(with input: Input, by key: String)`
    open override func invoke(with input: Input, key: String = #file) {
        self.lastEmitedMessage = input
        self.listners[key]?(input)
    }

    /// Удаляет всех подписчиков.
    /// В том числе удаляет последнее запомненное сообщение.
    ///
    /// - SeeAlso: `Event.clear`
    open override func clear() {
        self.lastEmitedMessage = nil
        self.listners.removeAll()
    }

    open override func remove(key: String = #file) {
        self.listners.removeValue(forKey: key)
    }

    /// Удаляет последнее заполненное сообщение.
    open func eraseLastEmited() {
        self.lastEmitedMessage = nil
    }
}
