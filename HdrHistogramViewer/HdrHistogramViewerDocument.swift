//
//  HdrHistogramViewerDocument.swift
//  HdrHistogramViewer
//
//  Created by Joseph Heck on 3/4/23.
//

import SwiftUI
import UniformTypeIdentifiers
import ExtrasJSON
import Histogram

extension UTType {
    static var encodedHistogram: UTType {
        UTType(importedAs: "com.github.ordo-one.encodedHistogram")
    }
}

struct HdrHistogramViewerDocument: FileDocument {
    var histogram: Histogram<UInt>
    let decoder = XJSONDecoder()
    let encoder = XJSONEncoder()
    
    init(histogram: Histogram<UInt> = Histogram<UInt>(highestTrackableValue: 3_000_000_000)) {
        self.histogram = histogram
    }

    static var readableContentTypes: [UTType] { [.encodedHistogram, .json] }

    init(configuration: ReadConfiguration) throws {
        
        guard let data = configuration.file.regularFileContents
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.histogram = try decoder.decode(Histogram.self, from: data)
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try encoder.encode(histogram)
        return .init(regularFileWithContents: Data(data))
    }
}
