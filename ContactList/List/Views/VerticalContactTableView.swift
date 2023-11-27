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
    private let identifier = "ContactCell"
    var contacts = [ContactData]()
    private let dataRefreshControl = UIRefreshControl()
    var filteredContacts = [ContactData]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: .plain)
        configureTableView()
        setTableViewDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - contactTableView setup
    private func configureTableView() {
        self.showsVerticalScrollIndicator = false
        self.backgroundColor = .white
        self.register(ContactCell.self, forCellReuseIdentifier: identifier)
        self.separatorStyle = .none
    }
    
    // функция с установкой подписки на delegates
    func setTableViewDelegates() {
        self.delegate = self
        self.dataSource = self
    }
}

// MARK: - extensions for VerticalContactTableView
extension VerticalContactTableView: UITableViewDelegate, UITableViewDataSource {
    
    // функция для отображения количества строк на экране
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContacts.count
    }
    
    // настройка ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ContactCell
        let contact = filteredContacts[indexPath.row]
        cell.configure(contacts: contact)
        return cell
    }
}
