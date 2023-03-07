//
//  LocalIterationValue.swift
//  HdrHistogramViewer
//
//  Created by Joseph Heck on 3/4/23.
//

import Histogram
import Foundation

struct LocalIterationValue: Hashable, Identifiable {
    let id: UUID
    let count: UInt
    let prevValue: UInt64
    let value: UInt64
    let percentile: Double
    let percentileLevelIteratedTo: Double
    let countAddedInThisIterationStep: UInt64
    let totalCountToThisValue: UInt64
    let totalValueToThisValue: UInt64
    
    init(from: Histogram<UInt>.IterationValue) {
        self.id = UUID()
        self.count = from.count
        self.prevValue = from.prevValue
        self.value = from.value
        self.percentile = from.percentile
        self.percentileLevelIteratedTo = from.percentileLevelIteratedTo
        self.countAddedInThisIterationStep = from.countAddedInThisIterationStep
        self.totalCountToThisValue = from.totalCountToThisValue
        self.totalValueToThisValue = from.totalValueToThisValue
    }
}

extension RangeReplaceableCollection where Element: Hashable {
  mutating func removeDuplicates() {
    var alreadySeen: Set<Element> = []
    removeAll { !alreadySeen.insert($0).inserted }
  }
}

struct Converter {
    static func percentiles(_ hist: Histogram<UInt>) -> [LocalIterationValue] {
        var foo = hist.percentiles(ticksPerHalfDistance: 4)
            .map { LocalIterationValue(from: $0) }
        foo.removeDuplicates()
        return foo
    }
    
    static func percentileArray(_ hist: Histogram<UInt>) -> [(Double,UInt64)] {
        (0...100).map { intValue in
            let ptile = Double(intValue)
            let value = hist.valueAtPercentile(ptile)
            return (ptile, value)
        }
    }

    static func invertedPercentileArray(_ hist: Histogram<UInt>) -> [(Double,UInt64)] {
        [0.0, 50.0, 90.0, 99.0, 99.9, 99.99, 99.999]
        .map { ptile in
            let invertedPercentile = 1.0 - ptile/100.0
            let value = hist.valueAtPercentile(ptile)
            return (invertedPercentile, value)
        }
    }

    static func linearBuckets(_ hist: Histogram<UInt>, bucketCount: UInt64 = 1000) -> [LocalIterationValue] {
        let valuesPerBucket = max(hist.max/bucketCount, 1)
        return hist.linearBucketValues(valueUnitsPerBucket: valuesPerBucket)
            .map { LocalIterationValue(from: $0) }
    }
}
