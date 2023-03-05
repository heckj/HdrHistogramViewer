//
//  DistributionView.swift
//  HdrHistogramViewer
//
//  Created by Joseph Heck on 3/4/23.
//

import SwiftUI
import Histogram
import Charts

struct DistributionView: View {
    var histogram: Histogram<UInt>
    
    var body: some View {
        VStack {
            Text("Distribution of reported values")
            Chart {
                ForEach(Converter.linearBuckets(histogram)) { stat in
                    BarMark(
                        x: .value("Value", stat.value),
                        y: .value("Count", stat.count),
                        width: .fixed(2)
                    )
                }
            }
            .chartYAxis(.hidden)
            .chartXAxis(.hidden)
//            .chartXAxis {
//                AxisMarks(values: Converter.linearBuckets(histogram).map({ $0.value })) { value in
//                    AxisGridLine()
//                    AxisValueLabel(centered: true, orientation: .vertical
//                    ) {
//                        if let val = value.as(Int.self)
////                            , val % 10 == 0
//                        {
//                            Text("\(val)").font(.caption2)
//                        }
//                    }
//                }
//            }
            .frame(maxHeight: 50)
        }
    }
}

struct DistributionView_Previews: PreviewProvider {
    static var previews: some View {
        DistributionView(histogram: sampleHistogram)
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
