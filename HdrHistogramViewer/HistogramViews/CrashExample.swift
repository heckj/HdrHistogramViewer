//
//  CrashExample.swift
//  HdrHistogramViewer
//
//  Created by Joseph Heck on 3/5/23.
//

import SwiftUI
import Charts

struct Workout: Identifiable, Hashable {
    var id = UUID()
    var day: Int
    var minutes: Int
    
    static var walkData: [Workout] {
        [
            .init(day: 0, minutes: 3),
            .init(day: 1, minutes: 45),
            .init(day: 2, minutes: 76),
            .init(day: 3, minutes: 21),
            .init(day: 4, minutes: 15),
            .init(day: 5, minutes: 35),
            .init(day: 6, minutes: 10)
        ]
    }
}

struct CrashExample: View {
    let workouts = [
        (workoutType: "Walk", data: Workout.walkData),
    ]

    var body: some View {
        VStack {
            Chart {
                ForEach(workouts, id: \.workoutType) { series in
                    ForEach(series.data) { element in
                        LineMark(x: .value("Day", element.day), y: .value("Mins", element.minutes))
                    }
                }
            }
            .chartXScale(domain: .automatic(includesZero: false, reversed: true))
            // ^^ reversed: true crashes the simulator
            // Crash appears resolved in Xcode 15.3 beta 2, Swift 5.10
            .frame(height: 400)
            .padding()
        }
    }
}

struct CrashExample_Previews: PreviewProvider {
    static var previews: some View {
        CrashExample()
    }
}
