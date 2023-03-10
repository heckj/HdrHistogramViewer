//
//  ContentView.swift
//  HdrHistogramViewer
//
//  Created by Joseph Heck on 3/4/23.
//

import SwiftUI
import Histogram

struct ContentView: View {
    @Binding var document: HdrHistogramViewerDocument

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
    
    var body: some View {
        VStack {
            CountsView(histogram: document.histogram)
//            DiagnosticView(histogram: document.histogram)
            Group {
                DistributionHeatmap(histogram: document.histogram)
                DistributionView(histogram: document.histogram)
            }.frame(maxWidth: 400)
            HStack {
                OverallPercentileCurve(histogram: document.histogram)
                InvertedPercentileCurve(histogram: document.histogram)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(HdrHistogramViewerDocument()))
    }
}
