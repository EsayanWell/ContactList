//
//  APIManager.swift
//  ContactList
//
//  Created by Владимир Есаян on 24.10.2023.
//

import Foundation

// MARK: - Errors
enum NetworkError: Error {
    case noData
    case serverError
    case decodingError
}
// MARK: - APIManager class
// класс для управления сетевыми запросами
final class APIManager {
    // singleton
    static let shared = APIManager()
    
    func fetchUserData(completion: @escaping(Result<[ContactData], NetworkError>) -> Void) {
        print("try to fetch")
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
        //request.setValue("code=200, example=success", forHTTPHeaderField: "Prefer" )
        //request.setValue("code=500, example=error-500", forHTTPHeaderField: "Prefer" )
        
        // инициализируем сессию (shared означает, что используется общая сессия)
        let session = URLSession.shared
        // Создается задача сетевого запроса с использованием apiURL. Код, в фигурных скобках, представляет замыкание, которое будет выполнено по завершении запроса. Оно получает три параметра: data (данные, полученные в ответ на запрос), response (ответ на запрос) и error (ошибка, если она возникла)
        URLSession.shared.dataTask(with: request) { data, response, error  in
            // если ошибка произошла во время запроса (error == nil значит, что запрос прошел без ошибок)
            guard error == nil else {
                print("Error in session is not nil")
                completion(.failure(.noData))
                return
            }
            // получаем статус код
            let httpResponse = response as? HTTPURLResponse
            print("status code: \(httpResponse?.statusCode ?? 0)")
            // если статус код 500
            guard httpResponse?.statusCode != 500 else {
                completion(.failure(.serverError))
                return
            }
            // обработка полученных данных
            // проверяется, что данные (data) получены без ошибок. Если данные присутствуют и нет ошибки, код продолжает выполнение. В противном случае, он завершается без выполнения дополнительных действий.
            guard let safeData = data else { return }
            // декодирование с возможностью перехватывания ошибок
            do {
                // декодирование try - попытайся декодировать из данных
                let decodedQuery = try JSONDecoder().decode(Query.self, from: safeData)
                print("Success decoding")
                completion(.success(decodedQuery.items))
            } catch let decodeError {
                print("Decoding error: \(decodeError)")
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
