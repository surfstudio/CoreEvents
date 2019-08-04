//
//  PresentEventTest.swift
//  CoreEventsTests
//
//  Created by Alexander Kravchenkov on 13.04.2018.
//  Copyright © 2018 Alexander Kravchenkov. All rights reserved.
//

import XCTest
@testable import CoreEvents

class PresentEventTest: XCTestCase {

    // MARK: - Nested

    private struct EventContainer {
        var event = PresentEvent<String>()

        func emit(value: String) {
            event.invoke(with: value)
        }
    }

    // MARK: - Positive tests

    func testThatEventEmitsValue() {

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

    func testManyListnersFrom1FileProduce1Emit() {
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

    func testThatEventEmitsManyTimes() {
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

    func testThatClearMethodWorkSuccess() {
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

        // Assret

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

        // Assret

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

        // Assret

        emiter.event.remove()

        emiter.emit(value: "Hello World")

        XCTAssertEqual(firstEmited.count, 1)
        XCTAssertEqual(lastEmited.count, 2)
    }
}
