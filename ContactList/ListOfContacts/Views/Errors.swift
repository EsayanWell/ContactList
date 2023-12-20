//
//  Errors.swift
//  ContactList
//
//  Created by Владимир Есаян on 03.11.2023.
//

import Foundation

private func warningMessage (error: NetworkError) -> String {
    switch error {
    case .noData:
        return "Data cannot be found at this URL"
    case .serverError:
        return "500: No data"
    case .decodingError:
        return "Can't decode data"
    }
}
