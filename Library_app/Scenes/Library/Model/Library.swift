//
//  Library.swift
//  Library_app
//
//  Created by Maksim Matveichuk on 13.04.23.
//

import Foundation

struct Library: Codable {
    let query: String
    let works: [Work]
    let days, hours: Int
}

// MARK: - Work
struct Work: Codable {
    let key, title: String
    let editionCount, firstPublishYear: Int
    let hasFulltext, publicScanB: Bool
    let ia: [String]?
    let iaCollectionS, lendingEditionS, lendingIdentifierS, coverEditionKey: String?
    let coverI: Int?
    let language: [String]?
    let authorKey, authorName: [String]?
    let idStandardEbooks: [String]?
    let subtitle: String?
    let idProjectGutenberg, idLibrivox: [String]?

    enum CodingKeys: String, CodingKey {
        case key, title
        case editionCount = "edition_count"
        case firstPublishYear = "first_publish_year"
        case hasFulltext = "has_fulltext"
        case publicScanB = "public_scan_b"
        case ia
        case iaCollectionS = "ia_collection_s"
        case lendingEditionS = "lending_edition_s"
        case lendingIdentifierS = "lending_identifier_s"
        case coverEditionKey = "cover_edition_key"
        case coverI = "cover_i"
        case language
        case authorKey = "author_key"
        case authorName = "author_name"
        case idStandardEbooks = "id_standard_ebooks"
        case subtitle
        case idProjectGutenberg = "id_project_gutenberg"
        case idLibrivox = "id_librivox"
    }
}
