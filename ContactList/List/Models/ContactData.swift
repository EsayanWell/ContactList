//
//  Contact.swift
//  ContactList
//
//  Created by Владимир Есаян on 04.10.2023.
//

import Foundation
import UIKit




// MARK: - Item
struct ContactData: Codable {
    let id: String
    let avatarURL: String
    let firstName, lastName, userTag, department: String
    let position, birthday, phone: String

    enum CodingKeys: String, CodingKey {
        case id
        case avatarURL = "avatarUrl"
        case firstName, lastName, userTag, department, position, birthday, phone
    }
}

// MARK: - ContactData
struct Query: Codable {
    let items: [ContactData]
}
