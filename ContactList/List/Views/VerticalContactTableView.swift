//
//  VerticalContactTableView.swift
//  ContactList
//
//  Created by Владимир Есаян on 16.10.2023.
//

import Foundation
import UIKit
import SnapKit

class VerticalContactTableView: UITableView {
    
    // MARK: - Constants
    private var contactTableView = UITableView()
    private let identifier = "ContactCell"
    private let apiManager = APIManager()
    private var contacts: [ContactData] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: .plain)
        configureTableView()
        setCollectionViewDelegates()
        fetchContactData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - contactTableView setup
    private func configureTableView() {
        self.rowHeight = 80
        self.showsVerticalScrollIndicator = false
        self.backgroundColor = .white
        self.register(ContactCell.self, forCellReuseIdentifier: identifier)
        
    }
    
    // функция с установкой подписки на delegates
    func setCollectionViewDelegates() {
        self.delegate = self
        self.dataSource = self
    }
    
    // MARK: - Data from API
    func fetchContactData() {
        // [weak self] - Это захват самого объекта self с использованием слабой ссылки, чтобы избежать утечек памяти (retain cycles), связанных с замыканием. Это важно, чтобы избежать утечек памяти при работе с замыканиями и делегатами.
        // вызываю метод для получения данных с API
        apiManager.fetchUserData { [weak self] contactData, error  in
           
            DispatchQueue.main.async {
                guard let self else { return }
                // проверка, чтобы убедиться, что данные о контактах были успешно получены. Если contacts не равно nil, это означает, что данные были успешно получены.
                self.contacts = contactData!
                self.contactTableView.reloadData()

        }
          
        }
    }
}

// MARK: - extensions for VerticalContactTableView
extension VerticalContactTableView: UITableViewDelegate, UITableViewDataSource {
    
    // функция для отображения количества строк на экране
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ContactCell
        let contact = contacts[indexPath.row]
       // cell.configure(item: contact)


        // Загрузка изображения из URL (это можно сделать асинхронно)

        return cell
    }
}
