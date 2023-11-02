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
    private var contacts: [ContactData] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: .plain)
        configureTableView()
        setTableViewDelegates()
      //  fetchContactData()
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
    func setTableViewDelegates() {
        self.delegate = self
        self.dataSource = self
    }
    
    // MARK: - Data from API
    func fetchContactData() {
        APIManager.fetchUserData { [weak self] values in
            guard let self else { return }
            self.contacts = values
            self.contactTableView.reloadData()
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
        cell.configure(contacts: contact)
        return cell
    }
}
