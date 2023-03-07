//
//  DistributionHeatmap.swift
//  HdrHistogramViewer
//
//  Created by Joseph Heck on 3/6/23.
//

import SwiftUI
import Histogram
import Charts
import GameplayKit

struct DistributionHeatmap: View {
    var histogram: Histogram<UInt>
    let values: [LocalIterationValue]
    let highestCountInDistribution: Int
    let bucketCount: UInt64
    var body: some View {
        Chart {
            ForEach(self.values) { stat in
                RectangleMark(
                    xStart: .value("v1", stat.prevValue),
                    xEnd: .value("v1", stat.value)
                )
                .opacity(Double(stat.count)/Double(highestCountInDistribution))
    //            PointMark(
    //                x: .value("Value", stat.value),
    //                y: .value("Count", stat.count)
    //            )
            }
        }
        .chartYAxis(.hidden)
        .chartXAxis(.hidden)
//        .chartXAxis {
//            AxisMarks(position: .automatic,
//                      values: .automatic(minimumStride: 10,
//                                         desiredCount: 10,
//                                         roundLowerBound: true,
//                                         roundUpperBound: true)
//            ) { axisValue in
//                AxisGridLine()
//                AxisTick()
//                AxisValueLabel(orientation: .vertical)
//            }
//        }
        .chartPlotStyle { plotArea in
            plotArea
                .background(.gray.opacity(0.1))
//                .border(.blue, width: 1)
        }
        .frame(minHeight: 10, maxHeight: 40)
    }

    init(histogram: Histogram<UInt>, bucketCount: UInt64 = 500) {
        self.histogram = histogram
        self.bucketCount = bucketCount
        self.values = Converter.linearBuckets(histogram, bucketCount: bucketCount)
        let temp: UInt = self.values.reduce(0) { partialResult, iterValue in
            max(partialResult, iterValue.count)
        }
        highestCountInDistribution = Int(temp)
    }
}

struct DistributionHeatmap_Previews: PreviewProvider {
    static var previews: some View {
        DistributionHeatmap(histogram: SampleHistogramData.pseudorandom)
            .previewLayout(.sizeThatFits)
    }
}


