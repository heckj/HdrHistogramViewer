//
//  CountsView.swift
//  HdrHistogramViewer
//
//  Created by Joseph Heck on 3/4/23.
//

import SwiftUI
import Histogram


struct CountsView: View {
    var histogram: Histogram<UInt>
    
    var body: some View {
        VStack {
            Text("min: \(histogram.min)")
            Text("min: \(histogram.max)")
            ForEach(Converter.percentiles(histogram), id: \.percentile) { iterValue in
                Text("%: \(iterValue.percentile) count: \(iterValue.count), value: \(iterValue.value)")
            }
        }
    }
    
}


struct CountsView_Previews: PreviewProvider {
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
        CountsView(histogram: sampleHistogram)
            .previewLayout(.sizeThatFits)
    }
}
