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
    var bucketCount: UInt64
    
    init(histogram: Histogram<UInt>, bucketCount: UInt64 = 500) {
        self.histogram = histogram
        self.bucketCount = bucketCount
    }
    
    var body: some View {
        Chart {
            ForEach(Converter.linearBuckets(histogram, bucketCount: self.bucketCount)) { stat in
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
        .frame(minHeight: 40, maxHeight: 100)
    }

}

struct DistributionView_Previews: PreviewProvider {
    static var previews: some View {
        DistributionView(histogram: SampleHistogramData.pseudorandom)
            .previewLayout(.sizeThatFits)
        DistributionView(histogram: SampleHistogramData.simple)
            .previewLayout(.sizeThatFits)
    }
}
