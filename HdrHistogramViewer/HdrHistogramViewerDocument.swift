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
        UTType(exportedAs: "com.github.ordo-one.encodedHistogram")
    }
}

struct HdrHistogramViewerDocument: FileDocument {
    var histogram: Histogram<UInt>
    let decoder = XJSONDecoder()
    let encoder = XJSONEncoder()
    
    static var readableContentTypes: [UTType] { [.encodedHistogram, .json] }
    static var writableContentTypes: [UTType] { [.encodedHistogram] }

    init() {
        // for creating a whole new document...
        histogram = Histogram<UInt>(numberOfSignificantValueDigits: .three)
    }
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.histogram = try decoder.decode(Histogram.self, from: data)
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        print("content type: \(configuration.contentType)")
        print("preferred filename: \(configuration.existingFile?.preferredFilename ?? "UNKNOWN")")
        print("filename: \(configuration.existingFile?.filename ?? "UNKNOWN")")
        let data = try encoder.encode(histogram)
        return .init(regularFileWithContents: Data(data))
    }
}
