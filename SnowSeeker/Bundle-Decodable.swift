//
//  Bundle-Decodable.swift
//  SnowSeeker
//
//  Created by Rob Ranf on 5/6/25.
//
import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        do {
            return try decoder.decode(T.self, from: data)
        } catch let DecodingError.keyNotFound(key, context) {
            fatalError(
                """
                Failed to decode \(file) from bundle due to missing 
                key '\(key.stringValue)' – \(context.debugDescription)
                """)
        } catch let DecodingError.typeMismatch(_, context) {
            fatalError(
                """
                Failed to decode \(file) from bundle due to type 
                mismatch – \(context.debugDescription)
                """)
        } catch let DecodingError.valueNotFound(type, context) {
            fatalError(
                """
                Failed to decode \(file) from bundle due to 
                missing \(type) value – \(context.debugDescription)
                """)
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON.")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}
