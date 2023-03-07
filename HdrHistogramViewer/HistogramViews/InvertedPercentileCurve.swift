//
//  PercentileCurve.swift
//  HdrHistogramViewer
//
//  Created by Joseph Heck on 3/4/23.
//

import Histogram
import SwiftUI
import Charts

struct InvertedPercentileCurve: View {
    var histogram: Histogram<UInt>
    
    var body: some View {
        VStack {
            Text("Value (\(String(describing: histogram.min...histogram.max))) at high percentiles")
            Chart {
                ForEach(Converter.invertedPercentileArray(histogram), id: \.0) { stat in
                    LineMark(
                        x: .value("percentile", stat.0),
                        y: .value("value", stat.1)
                    )
                    // Use curved line to join points
                    .interpolationMethod(.monotone)
                }
            }
            .chartXScale(
                domain: .automatic(includesZero: false, reversed: true),
                type: .log
            )
            .chartXAxis {
                AxisMarks(values: Converter.invertedPercentileArray(histogram).map{ $0.0 }
                ) { value in
                    AxisGridLine()
            //                    AxisTick(centered: true,
            //                             stroke: StrokeStyle(lineWidth: 2))
            //                    .foregroundStyle(Color.red)
                    AxisValueLabel(centered: true, anchor: .top) {
                        if let invertedPercentile = value.as(Double.self) {
                            Text("\( ( (1 - invertedPercentile)*100.0).formatted(.number.precision(.significantDigits(1...5)))) ")
                        }
                    }
                }
            }
            
            .frame(maxWidth: 400, maxHeight: 200)
        }
    
    }
}

struct InvertedPercentileCurve_Previews: PreviewProvider {    
    static var previews: some View {
        InvertedPercentileCurve(histogram: SampleHistogramData.simple)
            .previewLayout(.sizeThatFits)
    }
}
