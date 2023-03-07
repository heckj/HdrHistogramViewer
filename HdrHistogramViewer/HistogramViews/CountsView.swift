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
        }
    }
    
}


struct CountsView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CountsView(histogram: SampleHistogramData.pseudorandom)
                .previewLayout(.sizeThatFits)
            
            CountsView(histogram: SampleHistogramData.simple)
                .previewLayout(.sizeThatFits)
        }
    }
}
