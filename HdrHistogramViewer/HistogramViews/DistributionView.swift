//
//  DistributionView.swift
//  HdrHistogramViewer
//
//  Created by Joseph Heck on 3/4/23.
//

import SwiftUI
import Histogram
import Charts

enum DistributionSize: UInt8, CaseIterable {
    case small = 1
    case medium = 2
    case large = 3
    
    var bucketCount: UInt64 {
        switch self {
        case .small:
            100
        case .medium:
            500
        case .large:
            1000
        }
    }
    
    var width: CGFloat {
        switch self {
        case .small:
            100
        case .medium:
            500
        case .large:
            1000
        }
    }
}

struct DistributionView: View {
    var histogram: Histogram<UInt>
    var size: DistributionSize
    
    init(histogram: Histogram<UInt>, size: DistributionSize = .large) {
        self.histogram = histogram
        self.size = size
    }
    
    var body: some View {
        VStack {
            Text("Distribution of reported values")
            Chart {
                ForEach(Converter.linearBuckets(histogram, bucketCount: self.size.bucketCount)) { stat in
                    BarMark(
                        x: .value("Value", stat.value),
                        y: .value("Count", stat.count),
                        width: .fixed(2)
                    )
                }
            }
            .chartYAxis(.hidden)
            .chartXAxis {
                AxisMarks(position: .automatic,
                          values: .automatic(minimumStride: 10,
                                             desiredCount: 10,
                                             roundLowerBound: true,
                                             roundUpperBound: true)
                ) { axisValue in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel(orientation: .vertical)
                }
            }
            .chartPlotStyle { plotArea in
                plotArea
                    .background(.gray.opacity(0.1))
                    .border(.blue, width: 1)
            }
            .frame(maxWidth: self.size.width, minHeight: 40, maxHeight: 100)
        }
    }
}

struct DistributionView_Previews: PreviewProvider {
    static var previews: some View {
        DistributionView(histogram: sampleHistogram, size: .large)
            .previewLayout(.sizeThatFits)
    }
    
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
    
}
