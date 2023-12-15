//
//  Contact.swift
//  ContactList
//
//  Created by Владимир Есаян on 04.10.2023.
//

import Foundation
import UIKit

// MARK: - Item
struct ContactData: Codable, Comparable {
    static func < (lhs: ContactData, rhs: ContactData) -> Bool {
        if lhs.lastName != rhs.lastName {
            return lhs.lastName < rhs.lastName
        } else {
            return lhs.firstName < rhs.firstName
        }
    }
    
    let id: String
    let avatarURL: String
    let firstName, lastName, userTag: String
    let department: Departments
    let position, birthday, phone: String
    var closestBirthday: Date? {
         let currentDate = Date()
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd"
         let currentYear = Calendar.current.component(.year, from: currentDate)
         let contactBirthdayComponents = Calendar.current.dateComponents([.month, .day], from: dateFormatter.date(from: birthday)!)
         var contactNextBirthdayComponents = DateComponents()
         contactNextBirthdayComponents.year = currentYear
         contactNextBirthdayComponents.month = contactBirthdayComponents.month
         contactNextBirthdayComponents.day = contactBirthdayComponents.day
         if let nextBirthdayDate = Calendar.current.date(from: contactNextBirthdayComponents) {
             if nextBirthdayDate < currentDate {
                 contactNextBirthdayComponents.year! += 1
             }
             return Calendar.current.date(from: contactNextBirthdayComponents)
         }
         return nil
     }

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
// CaseIterable - это протокол, который обеспечивает типам возможность создания коллекции своих кейсов 
enum Departments: String, CodingKey, Codable, CaseIterable {
    case all
    case android
    case iOS = "ios"
    case design
    case management
    case qa
    case backOffice = "back_office"
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
