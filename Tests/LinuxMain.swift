import XCTest
@testable import CodeTests
@testable import ConsolesTests

XCTMain([
    testCase(CodeTests.allTests),
    testCase(ConsolesTests.allTests),
])
