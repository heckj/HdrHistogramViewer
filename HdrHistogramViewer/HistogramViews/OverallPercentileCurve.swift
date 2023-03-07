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
    static var previews: some View {
        OverallPercentileCurve(histogram: SampleHistogramData.pseudorandom)
            .previewLayout(.sizeThatFits)
        OverallPercentileCurve(histogram: SampleHistogramData.simple)
            .previewLayout(.sizeThatFits)
    }
}
