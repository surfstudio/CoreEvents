//
//  PastEvent.swift
//  CoreEvents
//
//  Created by Alexander Kravchenkov on 13.04.2018.
//  Copyright © 2018 Alexander Kravchenkov. All rights reserved.
//

/// Этот тип событий запоминает все предыдущие сообщения.
/// Каждый новый подписчик получит все предыдущие сообщения.
///
/// - SeeAlso: `Event`
open class PastEvent<Input>: Event<Input> {

    public typealias Closure = (Input) -> Void

    private var listners: [String: Closure]
    private var laterEmits: [Input]

    public override init() {
        self.laterEmits = [Input]()
        self.listners = [:]
        super.init()
    }

    open override func add(key: String = #file, _ listner: @escaping Closure) {
        if !self.laterEmits.isEmpty {
            self.laterEmits.forEach { listner($0) }
        }
        self.listners[key] = listner
    }

    open override func invoke(with input: Input) {
        self.listners.keys.forEach { self.invoke(with: input, key: $0) }
    }

    open override func invoke(with input: Input, key: String = #file) {
        self.laterEmits.append(input)
        self.listners[key]?(input)
    }

    open override func clear() {
        self.laterEmits.removeAll()
        self.listners.removeAll()
    }

    open override func remove(key: String = #file) {
        self.listners.removeValue(forKey: key)
    }
}
