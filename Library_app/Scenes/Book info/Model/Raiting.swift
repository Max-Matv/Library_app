//
//  Raiting.swift
//  Library_app
//
//  Created by Maksim Matveichuk on 14.04.23.
//

import Foundation

struct Raiting: Codable {
    let summary: Summary
    let counts: [String: Int]
}

struct Summary: Codable {
    let average: Double
    let count: Int
    let sortable: Double
}
