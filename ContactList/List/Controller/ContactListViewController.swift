//
//  ViewController.swift
//  ContactList
//
//  Created by Владимир Есаян on 03.10.2023.
//

import UIKit
import SnapKit

class ContactListViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: - Constants
    private let departmentMenuCollectionView = HorizontalMenuCollectionView()
    private let departmentSeacrhBar = CustomSearchBar()
    private let departmentContactList = UITableView()
    private let errorReload = ErrorView()
    private let identifier = "ContactCell"
    private var contacts = [ContactData]()
    private let dataRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // скрываю NavigationBar
        navigationController?.setNavigationBarHidden(true, animated: true)
        // вызов функций
        setupViews()
        setConstraits()
        notHiddenErrorReload()
        hiddenErrorReload()
        configureTableView()
        setTableViewDelegates()
        fetchContactData()
        pullToRefreshSetup()
    }
    
    // MARK: - setupViews
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(departmentMenuCollectionView)
        view.addSubview(departmentSeacrhBar)
        view.addSubview(departmentContactList)
        view.addSubview(errorReload)
    }
    
    private func notHiddenErrorReload() {
        errorReload.isHidden = false
        departmentSeacrhBar.isHidden = true
        departmentMenuCollectionView.isHidden = true
        departmentContactList.isHidden = true
        print("Данные в таблице нет")
    }
    private func hiddenErrorReload() {
        // Если данные есть, удаляем кастомную view (если она была добавлена ранее)
        errorReload.isHidden = true
        departmentSeacrhBar.isHidden = false
        departmentMenuCollectionView.isHidden = false
        departmentContactList.isHidden = false
        print("Данные в таблице есть \(contacts.count)")
    }
    
    
    // MARK: - contactTableView setup
    private func configureTableView() {
        departmentContactList.showsVerticalScrollIndicator = false
        departmentContactList.backgroundColor = .white
        departmentContactList.register(ContactCell.self, forCellReuseIdentifier: identifier)
        departmentContactList.separatorStyle = .none
    }
    
    // функция с установкой подписки на delegates
    func setTableViewDelegates() {
        departmentContactList.delegate = self
        departmentContactList.dataSource = self
    }
    
    // MARK: - setup pull to refresh
    private func pullToRefreshSetup() {
        dataRefreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        departmentContactList.addSubview(dataRefreshControl)
    }
    
    // MARK: - Re-fetch API data
    @objc private func didPullToRefresh() {
        print("Start refresh")
        fetchContactData()
    }
    
    
    // MARK: - Data from API
    func fetchContactData() {
        print("Fetching data")
        
        APIManager.shared.fetchUserData { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let decodedContacts):
                    print("Success")
                    self.contacts = decodedContacts
                    self.dataRefreshControl.endRefreshing()
                    self.departmentContactList.reloadData()
                    self.hiddenErrorReload()
                case .failure(let networkError):
                    print("Failure: \(networkError)")
                    self.errorReload.isHidden = false
                    self.departmentSeacrhBar.isHidden = true
                    self.departmentMenuCollectionView.isHidden = true
                    self.departmentContactList.isHidden = true
                    self.notHiddenErrorReload()
                }
            }
        }
    }
    
    // MARK: - setConstraits
    private func setConstraits() {
        departmentSeacrhBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        departmentMenuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(departmentSeacrhBar.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview()
            make.height.equalTo(36)
        }
        departmentContactList.snp.makeConstraints { make in
            make.top.equalTo(departmentMenuCollectionView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
        errorReload.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(303)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - extensions for VerticalContactTableView
extension ContactListViewController: UITableViewDelegate, UITableViewDataSource {
    
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
