////
////  VerticalContactTableView.swift
////  ContactList
////
////  Created by Владимир Есаян on 16.10.2023.
////
//
//import Foundation
//import UIKit
//import SnapKit
//
//class VerticalContactTableView: UITableView {
//
//    // MARK: - Constants
//    private let identifier = "ContactCell"
//    private var contacts = [ContactData]()
//    private let dataRefreshControl = UIRefreshControl()
//
//    override init(frame: CGRect, style: UITableView.Style) {
//        super.init(frame: .zero, style: .plain)
//        configureTableView()
//        setTableViewDelegates()
//        fetchContactData()
//        pullToRefreshSetup()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // MARK: - contactTableView setup
//    private func configureTableView() {
//        self.showsVerticalScrollIndicator = false
//        self.backgroundColor = .white
//        self.register(ContactCell.self, forCellReuseIdentifier: identifier)
//        self.separatorStyle = .none
//    }
//
//    // функция с установкой подписки на delegates
//    func setTableViewDelegates() {
//        self.delegate = self
//        self.dataSource = self
//    }
//
//    // MARK: - setup pull to refresh
//    private func pullToRefreshSetup() {
//        dataRefreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
//        self.addSubview(dataRefreshControl)
//    }
//
//    // MARK: - Re-fetch API data
//    @objc private func didPullToRefresh() {
//        print("Start refresh")
//        fetchContactData()
//    }
//
//    // MARK: - Data from API
//    func fetchContactData() {
//        print("Fetching data")
//
//        APIManager.shared.fetchUserData { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let decodedContacts):
//                    print("Success")
//                    self.contacts = decodedContacts
//                    self.dataRefreshControl.endRefreshing()
//                    self.reloadData()
//                    //self.isHidden = false
//                case .failure(let networkError):
//                    print("Failure: \(networkError)")
//                    //self.isHidden = true
//                }
//            }
//        }
//    }
//}
//
//// MARK: - extensions for VerticalContactTableView
//extension VerticalContactTableView: UITableViewDelegate, UITableViewDataSource {
//
//    // функция для отображения количества строк на экране
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return contacts.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ContactCell
//        let contact = contacts[indexPath.row]
//        cell.configure(contacts: contact)
//        return cell
//    }
//}
