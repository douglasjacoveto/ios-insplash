// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let image = try? newJSONDecoder().decode(Image.self, from: jsonData)

import Foundation

// MARK: - ImageElement
struct ImageElement: Codable {
    let id: String
    let width, height: Int
    let color: String
    let imageDescription, altDescription: String?
    let urls: Urls
    let likes: Int


    enum CodingKeys: String, CodingKey {
        case id
        case width, height, color
        case imageDescription = "description"
        case altDescription = "alt_description"
        case urls, likes
    }
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb: String
}
