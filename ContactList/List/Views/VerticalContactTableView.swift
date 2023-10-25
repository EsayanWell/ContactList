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
    private var contacts: [Contact] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: .plain)
        configureTableView()
        setCollectionViewDelegates()
        
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
        APIManager.shared.fetchUserData {[weak self] contacts, error in
            if let contacts = contacts {
                self?.contacts = contacts
                DispatchQueue.main.async {
                    self?.contactTableView.reloadData()
                }
            } else if let error = error {
                print("Ошибка при загрузке данных: \(error)")
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
        cell.profileFirstName.text = contact.firstName
        cell.profileLastName.text = contact.lastName
        cell.profilePosition.text = contact.position
        cell.profileUserTag.text = contact.userTag
        
        // Загрузка изображения из URL (это можно сделать асинхронно)
//        if let imageURL = URL(string: contact.avatarURL) {
//            if let data = try? Data(contentsOf: imageURL) {
//                cell.pro.image = UIImage(data: data)
//            }
//        }
        return cell
    }
}
