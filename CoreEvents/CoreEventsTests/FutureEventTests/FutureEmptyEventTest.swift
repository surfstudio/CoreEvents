//
//  FutureEmptyEventTests.swift
//  CoreEventsTests
//
//  Created by Alexander Kravchenkov on 13.04.2018.
//  Copyright © 2018 Alexander Kravchenkov. All rights reserved.
//

import XCTest
@testable import CoreEvents

class FutureEmptyEventTest: XCTestCase {

    // MARK: - Nested types

    private struct EventContainer {
        var event = FutureEmptyEvent()

        func emit() {
            event.invoke()
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

    func testThatEventCanEmitMulticast() {
        // Arrange

        let emiter = EventContainer()
        let listenersCount = 10

        // Act

        var emitsCount = 0

        for _ in 0..<listenersCount {
            emiter.event += {
                emitsCount += 1
            }
        }

        emiter.emit()

        // Assert

        XCTAssertEqual(emitsCount, listenersCount)
    }

    func testThatEventEventManyTimes() {
        // Arrange

        let emiter = EventContainer()
        let emitCount = 10

        // Act

        var reallyEmitsCount = 0

        emiter.event += {
            reallyEmitsCount += 1
        }

        for _ in 0..<emitCount {
            emiter.emit()
        }

        // Assert

        XCTAssertEqual(emitCount, reallyEmitsCount)
    }

    func testThatEventDoesntEmitOldMessagesForNewListner() {
        // Arrange

        let emiter = EventContainer()

        // Act

        var allEmitsCount = 0

        emiter.event += {
            allEmitsCount += 1
        }

        emiter.emit()

        var newEmitsCount = 0

        emiter.event += {
            newEmitsCount += 1
        }

        emiter.emit()

        // Assert

        XCTAssertEqual(newEmitsCount, allEmitsCount - 1)
    }

    func testThatClearMethodWorkSuccess() {
        // Arrange

        let emiter = EventContainer()

        // Act

        var emitsCount = 0

        emiter.event += {
            emitsCount += 1
        }

        emiter.emit()

        emiter.event.clear()

        emiter.emit()

        // Assert

        XCTAssertEqual(emitsCount, 1)
    }
}
