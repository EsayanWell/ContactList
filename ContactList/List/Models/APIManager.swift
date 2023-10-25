//
//  APIManager.swift
//  ContactList
//
//  Created by Владимир Есаян on 24.10.2023.
//

import Foundation
// MARK: - APIManage class
class APIManager {
    
    static let shared = APIManager()
    
    func fetchUserData(completion: @escaping([Contact]?, Error?) -> Void) {
        // получаем API
        let urlString = "https://stoplight.io/mocks/kode-education/trainee-test/25143926/users"
        // создаем URL и проверяем на ошибку
        guard let apiURL = URL(string: urlString) else {
            fatalError("error")
        }
       // var request = URLRequest(url: apiURL)
        // инициализируем сессию
        let session = URLSession.shared
        // создаем запрос dataTask
        let task = session.dataTask(with: apiURL) { data, response, error in
            // обработка полученных данных
            guard let data = data, error == nil else { return }
            // передача данных в главном потоке
            // Парсинг полученных данных
            do {
                let contacts = try JSONDecoder().decode([Contact].self, from: data)
                completion(contacts, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
