//
//  SampleData.swift
//  HdrHistogramViewer
//
//  Created by Joseph Heck on 3/6/23.
//

import GameplayKit
import Histogram

struct SampleHistogramData {
    static var pseudorandom: Histogram<UInt> {
        var h = Histogram<UInt>(numberOfSignificantValueDigits: .three)
        let wgw = GKMersenneTwisterRandomSource(seed: 34454)
        for _ in 0...250 {
            h.record(UInt64(wgw.nextInt(upperBound: 100)))
        }
        return h
    }

    static var simple: Histogram<UInt> {
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
