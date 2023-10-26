//
//  APIManager.swift
//  ContactList
//
//  Created by Владимир Есаян on 24.10.2023.
//

import Foundation

// MARK: - APIManager class
// класс для управления сетевыми запросами
class APIManager {
    // обеспечивает синглтон-подход к созданию и использованию APIManager.
    // синглтон гарантирует, что для определенного класса существует только один объект, и предоставляет механизм для доступа к этому объекту из любой точки программы
    static let shared = APIManager()
    // Это метод, который выполняет запрос на получение данных пользователей. Он принимает замыкание (completion), которое будет вызываться после завершения запроса с результатами. Это замыкание принимает два параметра: массив [Contact] (список контактов) и объект Error (ошибку), который будет передан после выполнения запроса.
    func fetchUserData(completion: @escaping([Contact]?, Error?) -> Void) {
        // строка, которая содержит URL-адрес, по которому будет отправлен сетевой запрос
        let urlString = "https://stoplight.io/mocks/kode-education/trainee-test/25143926/users"
        // создаем URL и проверяем на ошибку
        guard let apiURL = URL(string: urlString) else {
            fatalError("error")
        }
        // инициализируем сессию (shared означает, что используется общая сессия)
        let session = URLSession.shared
        // Создается задача сетевого запроса с использованием apiURL. Код, в фигурных скобках, представляет замыкание, которое будет выполнено по завершении запроса. Оно получает три параметра: data (данные, полученные в ответ на запрос), response (ответ на запрос) и error (ошибка, если она возникла)
        let task = session.dataTask(with: apiURL) { data, response, error in
            // обработка полученных данных
            // проверяется, что данные (data) получены без ошибок. Если данные присутствуют и нет ошибки, код продолжает выполнение. В противном случае, он завершается без выполнения дополнительных действий.
            guard let data = data, error == nil else { return }
            // Внутри блока do-catch данные (data) декодируются в массив объектов типа Contact с использованием JSONDecoder. Если декодирование прошло успешно, массив контактов передается в замыкание completion с nil в качестве ошибки, если декодирование не удалось (например, из-за некорректного формата данных) выдается ошибка
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
