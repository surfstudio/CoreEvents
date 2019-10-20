//
//  PastEventTests.swift
//  CoreEventsTests
//
//  Created by Alexander Kravchenkov on 13.04.2018.
//  Copyright © 2018 Alexander Kravchenkov. All rights reserved.
//

import XCTest
@testable import CoreEvents

class PastEventTests: XCTestCase {

    // MARK: - Nested

    private struct EventContainer {
        var event: Event<String> = PastEvent<String>()

        func emit(value: String) {
            event.invoke(with: value)
        }
    }

    // MARK: - Success Assert

    func testEventEmitsValue() {
        // Arrange

        let emiter = EventContainer()
        let message = "Hello world"

        // Act

        var emited: String?

        emiter.event.add { value in
            emited = value
        }

        emiter.emit(value: message)

        // Assert

        XCTAssertEqual(message, emited)
    }

    func testManyListenersFrom1FileProduce1Emit() {
        // Arrange

        let emiter = EventContainer()
        let message = "Hello world"
        let listenersCount = 10

        // Act

        var emited = [String]()

        for _ in 0..<listenersCount {
            emiter.event.add { value in
                emited.append(value)
            }
        }

        emiter.emit(value: message)

        // Assert

        XCTAssertEqual(emited.count, 1)
        emited.forEach { XCTAssertEqual($0, message) }
    }

    func testEventEmitsManyTimes() {
        // Arrange

        let emiter = EventContainer()
        let message = "Hello world"
        let emitCount = 10

        // Act

        var emited = [String]()

        emiter.event.add { value in
            emited.append(value)
        }

        for _ in 0..<emitCount {
            emiter.emit(value: message)
        }

        // Assert

        XCTAssertEqual(emited.count, emitCount)
        emited.forEach { XCTAssertEqual($0, message) }
    }

    func testEmitsAllLastEmitedMessage() {
        // Arrange

        let emiter = EventContainer()
        let firstMessage = "Hello world"
        let secondMessage = "Hello (:"
        let thirdMessage = "How are you?"

        // Act

        var allEmited = [String]()

        emiter.event.add { value in
            allEmited.append(value)
        }

        emiter.emit(value: firstMessage)
        emiter.emit(value: secondMessage)

        var newEmited = [String]()

        emiter.event.add { value in
            newEmited.append(value)
        }

        emiter.emit(value: thirdMessage)

        // Assert

        XCTAssertEqual(newEmited.count, 3)
    }

    func testClearMethodWorksSuccess() {
        // Arrange

        let emiter = EventContainer()
        let firstMessage = "Hello world"
        let lastMessage = "Hello (:"

        // Act

        var emited = [String]()

        emiter.event.add { value in
            emited.append(value)
        }

        emiter.emit(value: firstMessage)

        emiter.event.clear()

        emiter.emit(value: lastMessage)

        // Assert

        XCTAssertEqual(emited.count, 1)
    }

    func testAddingByKeySuccess() {
        // Arrange

        let emiter = EventContainer()

        var firstEmited = [String]()
        var lastEmited = [String]()

        // Act

        emiter.event.add(key: "1") { firstEmited.append($0) }
        emiter.event.add(key: "2") { lastEmited.append($0) }

        emiter.emit(value: "Hello World")

        // Assert

        XCTAssertEqual(firstEmited.count, 1)
        XCTAssertEqual(lastEmited.count, 1)
    }

    func testRemovingByKeySuccess() {
        // Arrange

        let emiter = EventContainer()

        var firstEmited = [String]()
        var lastEmited = [String]()

        // Act

        emiter.event.add(key: "1") { firstEmited.append($0) }
        emiter.event.add(key: "2") { lastEmited.append($0) }

        emiter.emit(value: "Hello World")

        // Assert

        emiter.event.remove(key: "1")

        emiter.emit(value: "Hello World")

        XCTAssertEqual(firstEmited.count, 1)
        XCTAssertEqual(lastEmited.count, 2)
    }

    func testRemovingByDefaultKeySuccess() {
        // Arrange

        let emiter = EventContainer()

        var firstEmited = [String]()
        var lastEmited = [String]()

        // Act

        emiter.event.add { firstEmited.append($0) }
        emiter.event.add(key: "2") { lastEmited.append($0) }

        emiter.emit(value: "Hello World")

        // Assert

        emiter.event.remove()

        emiter.emit(value: "Hello World")

        XCTAssertEqual(firstEmited.count, 1)
        XCTAssertEqual(lastEmited.count, 2)
    }
}
