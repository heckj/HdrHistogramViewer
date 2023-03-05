//
//  HdrHistogramViewerTests.swift
//  HdrHistogramViewerTests
//
//  Created by Joseph Heck on 3/4/23.
//

import XCTest
import Histogram
@testable import HdrHistogramViewer

final class HdrHistogramViewerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDerivedOneMinusPercentile() throws {
        let x = LocalIterationValue(count: 4, value: 79, percentile: 99.9)
        
        XCTAssertEqual(x.oneMinusPercentile, 0.001, accuracy: 0.0001)

        XCTAssertEqual(LocalIterationValue(count: 4, value: 79, percentile: 99.999).oneMinusPercentile, 0.00001, accuracy: 0.00001)

    }
    
    func testInvertedPercentiles() throws {
        var h = Histogram<UInt>(numberOfSignificantValueDigits: .three)
        h.record(5)
        h.record(6)
        h.record(5)
        h.record(10)
        h.record(4)
        h.record(6)
        h.record(50)

        let tupleArray = Converter.invertedPercentileArray(h)
        XCTAssertEqual(tupleArray.count, 7)
        XCTAssertEqual(tupleArray[0].0, 0.99, accuracy: 0.01)
        XCTAssertEqual(tupleArray[1].0, 0.5, accuracy: 0.01)
        XCTAssertEqual(tupleArray[2].0, 0.1, accuracy: 0.01)
        XCTAssertEqual(tupleArray[3].0, 0.01, accuracy: 0.001)
        XCTAssertEqual(tupleArray[4].0, 0.001, accuracy: 0.0001)
        XCTAssertEqual(tupleArray[5].0, 0.0001, accuracy: 0.00001)
        XCTAssertEqual(tupleArray[6].0, 0.00001, accuracy: 0.000001)
        // print(tupleArray)
        // [(0.99, 4), (0.5, 6), (0.09999999999999998, 50), (0.010000000000000009, 50), (0.0009999999999998899, 50), (0.00010000000000010001, 50), (1.0000000000065512e-05, 50)]
    }

}
