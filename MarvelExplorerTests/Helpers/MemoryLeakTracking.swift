//
//  MemoryLeakTracking.swift
//  MarvelExplorerTests
//
//  Created by Sherif Shokry on 12/11/2024.
//

import XCTest
@testable import MarvelExplorer

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
