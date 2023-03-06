//
//  LocalIterationValue.swift
//  HdrHistogramViewer
//
//  Created by Joseph Heck on 3/4/23.
//

import Histogram

struct LocalIterationValue: Hashable, Identifiable {
    let count: UInt
    let value: UInt64
    let percentile: Double
    var oneMinusPercentile: Double {
        1.0 - percentile/100.0
    }
    
    // Identifiable conformance
    var id: Double {
        self.percentile
    }
    
    init(count: UInt, value: UInt64, percentile: Double) {
        self.count = count
        self.value = value
        self.percentile = percentile
    }
    
    init(from: Histogram<UInt>.IterationValue) {
        self.count = from.count
        self.value = from.value
        self.percentile = from.percentile
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
