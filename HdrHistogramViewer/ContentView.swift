//
//  ContentView.swift
//  HdrHistogramViewer
//
//  Created by Joseph Heck on 3/4/23.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: HdrHistogramViewerDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(HdrHistogramViewerDocument()))
    }
}
