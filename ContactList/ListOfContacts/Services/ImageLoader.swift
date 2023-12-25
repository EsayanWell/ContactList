//
//  ImageLoader.swift
//  ContactList
//
//  Created by Владимир Есаян on 22.12.2023.
//

import Foundation
import UIKit

// класс для загрузки фото с сервера
class ImageLoader {
    
    static func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        // Создается URL из переданной строки. Если не удается создать URL, завершение вызывается с nil и выполнение функции завершается
        guard let imageURL = URL(string: urlString) else {
            completion(nil)
            return
        }
        // Создается URLSession, который будет использоваться для загрузки данных из сети
        let session = URLSession.shared
        // Создается задача загрузки данных с использованием ранее созданного URL. Замыкание выполняется после завершения задачи загрузки данных.
        let task = session.dataTask(with: imageURL) { (data, response, error) in
            // Проверяется, есть ли какие-либо ошибки при загрузке данных. Если есть, то вызывается завершение с nil и функция завершается
            guard error == nil else {
                print("Ошибка при загрузке данных: \(error!)")
                completion(nil)
                return
            }
            // Если данные успешно загружены и удалось создать изображение из этих данных, то вызывается завершение с загруженным изображением. В противном случае вызывается завершение с nil
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                print("Ошибка при преобразовании данных в изображение")
                completion(nil)
            }
        }
        task.resume()
    }
}
