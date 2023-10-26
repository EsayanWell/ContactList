//
//  Contact.swift
//  ContactList
//
//  Created by Владимир Есаян on 04.10.2023.
//

import Foundation
import UIKit


// MARK: - ContactData
struct ContactData: Codable {
    let items: [Contact]
}

// MARK: - Contact
struct Contact: Codable {
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
