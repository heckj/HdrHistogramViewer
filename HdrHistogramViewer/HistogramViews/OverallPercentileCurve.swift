//
//  PercentileCurve.swift
//  HdrHistogramViewer
//
//  Created by Joseph Heck on 3/4/23.
//

import Histogram
import SwiftUI
import Charts

struct OverallPercentileCurve: View {
    var histogram: Histogram<UInt>
    
    var body: some View {
        VStack {
            Text("Value (\(String(describing: histogram.min...histogram.max))) at percentile of distribution")
            Chart {
                ForEach(Converter.percentileArray(histogram), id: \.0) { stat in
                    LineMark(
                        x: .value("percentile", stat.0),
                        y: .value("value", stat.1)
                    )
                    // Use curved line to join points
                    .interpolationMethod(.monotone)
                }
            }
            .frame(maxWidth: 200, maxHeight: 200)
        }
    
    }
}

struct OverallPercentileCurve_Previews: PreviewProvider {
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
        OverallPercentileCurve(histogram: sampleHistogram)
//            .previewLayout(.fixed(width: 300, height: 300))
            .previewLayout(.sizeThatFits)
    }
}
