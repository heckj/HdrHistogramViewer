//
//  CountsView.swift
//  HdrHistogramViewer
//
//  Created by Joseph Heck on 3/4/23.
//

import SwiftUI
import Histogram

extension SignificantDigits: CustomStringConvertible {
    public var description: String {
        switch self {
        case .zero:
            "0"
        case .one:
            "1"
        case .two:
            "2"
        case .three:
            "3"
        case .four:
            "4"
        case .five:
            "5"
        }
    }
}

struct CountsView: View {
    var histogram: Histogram<UInt>
    
    var body: some View {
        VStack {
            Text("count: \(histogram.totalCount), min: \(histogram.min), max: \(histogram.max)")
            Text("mean: \(histogram.mean), median \(histogram.mean), stddev: \(histogram.stdDeviation)")
            Text("significant digits: \(String(describing: histogram.numberOfSignificantValueDigits))")
            
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
