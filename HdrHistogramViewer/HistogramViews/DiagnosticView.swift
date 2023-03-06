//
//  DiagnosticView.swift
//  HdrHistogramViewer
//
//  Created by Joseph Heck on 3/6/23.
//

import SwiftUI
import Histogram

struct DiagnosticView: View {
    var histogram: Histogram<UInt>

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Converter counts").font(.headline)
                Text("Converter.percentiles count: \(Converter.percentiles(histogram).count)")
                Text("Converter.linearBuckets count: \(Converter.linearBuckets(histogram).count)")
                Text("Converter.linearBuckets(10) count: \(Converter.linearBuckets(histogram, bucketCount: 10).count)")
                Text("Converter.linearBuckets(100) count: \(Converter.linearBuckets(histogram, bucketCount: 100).count)")
                Text("Converter.percentileArray count: \(Converter.percentileArray(histogram).count)")
                Text("Converter.invertedPercentileArray count: \(Converter.invertedPercentileArray(histogram).count)")
            }
            VStack(alignment: .leading) {
                Text("Raw Data").font(.headline)
                Text("histogram.allValues() count: \(histogram.allValues().map { LocalIterationValue(from: $0) }.count)")
                Text("histogram.linearBucketValues(1) count: \(histogram.linearBucketValues(valueUnitsPerBucket: 1).map { LocalIterationValue(from: $0) }.count)")
                Text("histogram.linearBucketValues(100) count: \(histogram.linearBucketValues(valueUnitsPerBucket: 100).map { LocalIterationValue(from: $0) }.count)")
                Text("histogram.linearBucketValues(1000) count: \(histogram.linearBucketValues(valueUnitsPerBucket: 1000).map { LocalIterationValue(from: $0) }.count)")
                Text("histogram.recordedValues() count: \(histogram.recordedValues().map { LocalIterationValue(from: $0) }.count)")

            }
        }
    }
}

struct DiagnosticView_Previews: PreviewProvider {
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
        DiagnosticView(histogram: sampleHistogram)
    }
}
