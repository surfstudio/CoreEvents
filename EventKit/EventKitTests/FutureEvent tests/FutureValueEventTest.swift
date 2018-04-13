//
//  FutureValueEventTest.swift
//  EventKitTests
//
//  Created by Alexander Kravchenkov on 13.04.2018.
//  Copyright © 2018 Alexander Kravchenkov. All rights reserved.
//

import XCTest
@testable import EventKit

class FutureValueEventTest: XCTestCase {

    // MARK: - Nested types

    private struct EventContainer {
        var event = FutureValueEvent<String, String>()

        func emit(value: String) -> String? {
            return event.valueListner?(value)
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

    func testTahatEventEmitValue() {

        // Arrange

        let emiter = EventContainer()
        let message = "Hello world"
        let returnMessage = String(message.reversed())

        // Act

        var emited: String?

        emiter.event.valueListner = { value in
            emited = value
            return returnMessage
        }

        let emitResult = emiter.emit(value: message)

        // Assert

        XCTAssertEqual(message, emited)
        XCTAssertEqual(emitResult, returnMessage)
    }
}
