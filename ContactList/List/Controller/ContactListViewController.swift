//
//  ViewController.swift
//  ContactList
//
//  Created by Владимир Есаян on 03.10.2023.
//
import Foundation
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
    private var filteredContacts = [ContactData]()
    private let dataRefreshControl = UIRefreshControl()
    private var selectedDepartment: Departments = .all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // скрываю NavigationBar
        navigationController?.setNavigationBarHidden(true, animated: true)
        // вызов функций
        setupViews()
        errorViewToggleVisibility(isHidden: false)
        fetchContactData()
        pullToRefreshSetup()
        errorReloadSetup()
        departmentMenuCollectionView.filterDelegate = self
    }
    
    // MARK: - setupViews
    private func setupViews() {
        view.backgroundColor = .white
        // addSubviews
        view.addSubview(departmentMenuCollectionView)
        view.addSubview(departmentSeacrhBar)
        view.addSubview(departmentContactList)
        view.addSubview(errorReload)
        
        // MARK: - contactTableView setup
        departmentContactList.showsVerticalScrollIndicator = false
        departmentContactList.backgroundColor = .white
        departmentContactList.register(ContactCell.self, forCellReuseIdentifier: identifier)
        departmentContactList.separatorStyle = .none
        departmentContactList.delegate = self
        departmentContactList.dataSource = self
        
        // MARK: - make constraits
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
    
    // MARK: - errorReloadSetup
    private func errorReloadSetup(){
        errorReload.tryRequestButton.addTarget(self, action: #selector(updateRequest), for: .touchUpInside)
    }
    
    @objc func updateRequest() {
        print("Try to send request again")
        fetchContactData()
    }
    
    // метод, который срабатывает в зависимости от того, спрятана ли errorView
    private func errorViewToggleVisibility(isHidden: Bool) {
        departmentSeacrhBar.isHidden = isHidden
        departmentMenuCollectionView.isHidden = isHidden
        departmentContactList.isHidden = isHidden
        
        if isHidden {
            print("Данных в таблице нет")
        } else {
            print("Данные в таблице есть: \(contacts.count)")
        }
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
    private func fetchContactData() {
        print("Fetching data")
        
        APIManager.shared.fetchUserData { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let decodedContacts):
                    print("Success")
                    self.contacts = decodedContacts
                    self.dataRefreshControl.endRefreshing()
                    self.departmentContactList.reloadData()
                    self.errorReload.isHidden = true
                    self.errorViewToggleVisibility(isHidden: false)
                case .failure(let networkError):
                    print("Failure: \(networkError)")
                    self.errorReload.isHidden = false
                    self.errorViewToggleVisibility(isHidden: true)
                }
            }
        }
    }
}

// MARK: - extensions for VerticalContactTableView
extension ContactListViewController: UITableViewDelegate, UITableViewDataSource, FilterDelegate {
    
    // функция для отображения количества строк на экране
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ContactCell
        let contact = filteredContacts[indexPath.row]
        cell.configure(contacts: contact)
        return cell
    }
    
    // MARK: - filtered data
    internal func didSelectFilter(at indexPath: IndexPath) {
        
        if selectedDepartment == .all {
            filteredContacts = contacts
            print("Выбран фильтр Все")
        } else {
            filteredContacts = contacts.filter { $0.department == selectedDepartment }
            print("Выбран фильтр \(selectedDepartment)")
        }

        if filteredContacts.isEmpty {
            departmentContactList.isHidden = true
            print("Нет данных по выбранному фильтру")
        } else {
            departmentContactList.reloadData()
            print("Данные по выбранному фильтру есть")
        }
    }
}
