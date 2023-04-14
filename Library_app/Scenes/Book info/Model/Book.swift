//
//  Book.swift
//  Library_app
//
//  Created by Maksim Matveichuk on 14.04.23.
//

import Foundation

struct Book: Codable {
    let title, key: String
    let description: Created
}

struct Created: Codable {
    let value: String
}
