//
//  HdrHistogramViewerApp.swift
//  HdrHistogramViewer
//
//  Created by Joseph Heck on 3/4/23.
//

import SwiftUI

@main
struct HdrHistogramViewerApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: HdrHistogramViewerDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
