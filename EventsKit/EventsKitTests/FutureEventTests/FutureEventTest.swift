//
//  EventKitTests.swift
//  EventKitTests
//
//  Created by Alexander Kravchenkov on 13.04.2018.
//  Copyright © 2018 Alexander Kravchenkov. All rights reserved.
//

import XCTest
@testable import EventsKit

class FutureEventTest: XCTestCase {

    // MARK: - Nested types

    private struct EventContainer {
        var event = FutureEvent<String>()

        func emit(value: String) {
            event.invoke(with: value)
        }
    }

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Positive tests

    func testThatEventEmitsValue() {

        // Arrange

        let emiter = EventContainer()
        let message = "Hello world"

        // Act

        var emited: String?

        emiter.event += { value in
            emited = value
        }

        emiter.emit(value: message)

        // Assert

        XCTAssertEqual(message, emited)
    }

    func testThatEventCanEmitMulticast() {
        // Arrange

        let emiter = EventContainer()
        let message = "Hello world"
        let listenersCount = 10

        // Act

        var emited = [String]()

        for _ in 0..<listenersCount {
            emiter.event += { value in
                emited.append(value)
            }
        }

        emiter.emit(value: message)

        // Assert

        XCTAssertEqual(emited.count, listenersCount)
        emited.forEach { XCTAssertEqual($0, message) }
    }

    func testThatEventEventManyTimes() {
        // Arrange

        let emiter = EventContainer()
        let message = "Hello world"
        let emitCount = 10

        // Act

        var emited = [String]()

        emiter.event += { value in
            emited.append(value)
        }

        for _ in 0..<emitCount {
            emiter.emit(value: message)
        }

        // Assert

        XCTAssertEqual(emited.count, emitCount)
        emited.forEach { XCTAssertEqual($0, message) }
    }

    func testThatEventDoesntEmitOldMessagesForNewListner() {
        // Arrange

        let emiter = EventContainer()
        let firstMessage = "Hello world"
        let lastMessage = "Hello (:"

        // Act

        var allEmited = [String]()

        emiter.event += { value in
            allEmited.append(value)
        }

        emiter.emit(value: firstMessage)

        var newEmited = [String]()

        emiter.event += { value in
            newEmited.append(value)
        }

        emiter.emit(value: lastMessage)

        // Assert

        XCTAssertEqual(newEmited.count, allEmited.count - 1)
        XCTAssertEqual(newEmited.first, lastMessage)
    }

    func testThatClearMethodWorkSuccess() {
        // Arrange

        let emiter = EventContainer()
        let firstMessage = "Hello world"
        let lastMessage = "Hello (:"

        // Act

        var emited = [String]()

        emiter.event += { value in
            emited.append(value)
        }

        emiter.emit(value: firstMessage)

        emiter.event.clear()

        emiter.event += { value in
            emited.append(value)
        }

        emiter.emit(value: lastMessage)

        // Assert

        XCTAssertEqual(emited.count, 2)
    }
}
