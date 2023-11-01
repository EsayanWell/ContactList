//
//  APIManager.swift
//  ContactList
//
//  Created by Владимир Есаян on 24.10.2023.
//

import Foundation

// MARK: - APIManager class
// класс для управления сетевыми запросами
struct APIManager {
    // обеспечивает синглтон-подход к созданию и использованию APIManager.
    // синглтон гарантирует, что для определенного класса существует только один объект, и предоставляет механизм для доступа к этому объекту из любой точки программы
    static let shared = APIManager()
    // Это метод, который выполняет запрос на получение данных пользователей. Он принимает замыкание (completion), которое будет вызываться после завершения запроса с результатами. Это замыкание принимает два параметра: массив [Contact] (список контактов) и объект Error (ошибку), который будет передан после выполнения запроса.
    func fetchUserData(completion: @escaping([ContactData]?, Error?) -> Void) {
        // строка, которая содержит URL-адрес, по которому будет отправлен сетевой запрос
        let urlString = "https://stoplight.io/mocks/kode-education/trainee-test/25143926/users"
        // создаем URL и проверяем на ошибку
        guard let apiURL = URL(string: urlString) else {
            fatalError("error")
        }
        // создаем запрос и устанавливаем метод (GET)
        var request = URLRequest(url: apiURL)
        request.httpMethod = "GET"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("code=200, dynamic=true", forHTTPHeaderField: "Prefer" )
        
        // инициализируем сессию (shared означает, что используется общая сессия)
        let session = URLSession.shared
        // Создается задача сетевого запроса с использованием apiURL. Код, в фигурных скобках, представляет замыкание, которое будет выполнено по завершении запроса. Оно получает три параметра: data (данные, полученные в ответ на запрос), response (ответ на запрос) и error (ошибка, если она возникла)
        let task = session.dataTask(with: request) { data, response, error  in
            // обработка полученных данных
            // проверяется, что данные (data) получены без ошибок. Если данные присутствуют и нет ошибки, код продолжает выполнение. В противном случае, он завершается без выполнения дополнительных действий.
            guard let safeData = data else { return }
            
            do {
                // декодирование
                // try - попытайся декодировать из данных
                let contactData = try JSONDecoder().decode(Query.self, from: safeData)
                print("Success decoding")
                
            } catch let decodeError {
                print("Decoding error: \(decodeError)")
            }
        }
        // запуск сессии
        task.resume()
    }
}




