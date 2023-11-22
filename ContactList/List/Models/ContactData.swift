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
    let firstName, lastName, userTag: String
    let department: Departments
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

// Определение перечисления для департаментов
enum Departments: String, CodingKey, Codable {
    case all
    case android
    case iOS
    case design
    case management
    case qa
    case backOffice
    case frontend
    case hr
    case pr
    case backend
    case support
    case analytics

    var title: String {
        switch self {
        case .all:
            return "Все"
        case .android:
            return "Android"
        case .iOS:
            return "iOS"
        case .design:
            return "Дизайн"
        case .management:
            return "Менеджмент"
        case .qa:
            return "QA"
        case .backOffice:
            return "Бэк-офис"
        case .frontend:
            return "Frontend"
        case .hr:
            return "HR"
        case .pr:
            return "PR"
        case .backend:
            return "Backend"
        case .support:
            return "Техподдержка"
        case .analytics:
            return "Аналитика"
        }
    }
}
