//
//  PercentileCurve.swift
//  HdrHistogramViewer
//
//  Created by Joseph Heck on 3/4/23.
//

import Histogram
import SwiftUI
import Charts

extension RangeReplaceableCollection where Element: Hashable {
  mutating func removeDuplicates() {
    var alreadySeen: Set<Element> = []
    removeAll { !alreadySeen.insert($0).inserted }
  }
}

struct LocalIterationValue: Hashable, Identifiable {
    let count: UInt
    let value: UInt64
    let percentile: Double
    
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

struct PercentileCurve: View {
    var histogram: Histogram<UInt>
    
    var percentiles: [LocalIterationValue] {
        var foo = histogram.percentiles(ticksPerHalfDistance: 4)
            .map { LocalIterationValue(from: $0) }
        foo.removeDuplicates()
        return foo
    }
    
    var percentileArray: [(Double,UInt64)] {
        (0...100).map { intValue in
            let ptile = Double(intValue)
            let value = histogram.valueAtPercentile(ptile)
            return (ptile, value)
        }
    }
    
    var linearBuckets: [LocalIterationValue] {
        histogram.linearBucketValues(valueUnitsPerBucket: 1)
            .map { LocalIterationValue(from: $0) }
    }
    
//    Chart {
//                ForEach(stats, id: \.city) { stat in
//                    BarMark(
//                        x: .value("City", stat.city),
//                        y: .value("Population", stat.population)
//                    )
//                }
//            }
    
    var body: some View {
        HStack {
            VStack {
              Text("Histogram Distribution")
                Chart {
                    ForEach(self.linearBuckets) { stat in
                        BarMark(
                            x: .value("Value", stat.value),
                            y: .value("Count", stat.count)
                        )
                    }
                }.frame(maxHeight: 100)
            }
            VStack {
                ForEach(self.linearBuckets, id: \.value) { iterValue in
                    Text("value: \(iterValue.value) #: \(iterValue.count)")
                }
            }
            VStack {
                Text("min: \(histogram.min)")
                Text("min: \(histogram.max)")
                ForEach(self.percentiles, id: \.percentile) { iterValue in
                    Text("%: \(iterValue.percentile) #: \(iterValue.count), value: \(iterValue.value)")
                }
            }
            VStack {
                Text("Recorded value \(String(describing: histogram.min...histogram.max)) at percentile of distribution")
                Chart {
                    ForEach(self.percentileArray, id: \.0) { stat in
                        LineMark(
                            x: .value("percentile", stat.0),
                            y: .value("value", stat.1)
                        )
                    }
                }
                .frame(maxHeight: 100)
            }
//            VStack {
//                ForEach(self.percentileArray, id: \.0) { tuple in
//                    Text("%tile: \(tuple.0) => \(tuple.1) ")
//                }
//            }

        }
    }
}

struct PercentileCurve_Previews: PreviewProvider {
    static var sampleHistogram: Histogram<UInt> {
        var h = Histogram<UInt>(numberOfSignificantValueDigits: .three)
        h.record(5)
        h.record(6)
        h.record(5)
        h.record(10)
        h.record(4)
        h.record(6)
        h.record(50)
        return h
    }
    
    static var previews: some View {
        PercentileCurve(histogram: sampleHistogram)
//            .previewLayout(.fixed(width: 300, height: 300))
            .previewLayout(.sizeThatFits)
    }
}
