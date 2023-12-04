//
//  ViewController.swift
//  ContactList
//
//  Created by Владимир Есаян on 03.10.2023.
//
import Foundation
import UIKit
import SnapKit

// протокол для передачи данных между контроллером и customSearchBar
protocol CustomSearchBarDelegate: AnyObject {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
}

class ContactListViewController: UIViewController {
    
    // MARK: - Constants
    private let departmentMenuCollectionView = HorizontalMenuCollectionView()
    private let departmentSearchBar = CustomSearchBar()
    private var contacts = [ContactData]()
    private let dataRefreshControl = UIRefreshControl()
    private var filteredContacts = [ContactData]()
    private let departmentContactList = VerticalContactTableView()
    private let errorReload = ErrorLoadView()
    private var errorSearch = ErrorSeacrhView()
    private let identifier = "ContactCell"
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
        // подписка на delegate
        departmentMenuCollectionView.filterDelegate = self
        // устанавливаем в качестве делегата
        departmentSearchBar.searchDelegate = self
        errorSearch.isHidden = true
        
    }
    
    // MARK: - setupViews
    private func setupViews() {
        view.backgroundColor = .white
        // addSubviews
        view.addSubview(departmentMenuCollectionView)
        view.addSubview(departmentSearchBar)
        view.addSubview(departmentContactList)
        view.addSubview(errorReload)
        view.addSubview(errorSearch)
        
        // setup UITableView
        departmentContactList.delegate = self
        departmentContactList.dataSource = self
        
        // MARK: - make constraits
        departmentSearchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        departmentMenuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(departmentSearchBar.snp.bottom).offset(8)
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
        errorSearch.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(220)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: - errorReloadSetup
    // ошибка загрузки
    private func errorReloadSetup(){
        errorReload.tryRequestButton.addTarget(self, action: #selector(updateRequest), for: .touchUpInside)
    }
    
    @objc func updateRequest() {
        print("Try to send request again")
        fetchContactData()
    }
    
    // MARK: - errorViewToggleVisibility
    // метод, который срабатывает в зависимости от того, спрятана ли errorView
    private func errorViewToggleVisibility(isHidden: Bool) {
        departmentSearchBar.isHidden = isHidden
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
        departmentContactList.reloadData()
    }
    
    // MARK: - Re-fetch API data
    @objc private func didPullToRefresh() {
        print("Start refresh")
        fetchContactData()
        dataRefreshControl.endRefreshing()
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

// MARK: - extensions for VerticalContactTableView and DepartmentSearchBar
extension ContactListViewController: UITableViewDelegate, UITableViewDataSource, FilterDelegate, CustomSearchBarDelegate {
    
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
    
    // MARK: - filtered data delegate
    func didSelectFilter(at indexPath: IndexPath, selectedData: Departments) {
        
        selectedDepartment = selectedData
        // фильтрация данных, отображаемых на экране
        if selectedDepartment == .all {
            filteredContacts = contacts
            print("Выбран фильтр Все")
        } else {
            filteredContacts = contacts.filter { $0.department == selectedDepartment }
            print("Выбран фильтр \(selectedDepartment)")
        }
        
        if  filteredContacts.isEmpty {
            departmentContactList.isHidden = true
            print("Нет данных по выбранному фильтру")
        } else {
            departmentContactList.reloadData()
            departmentContactList.isHidden = false
            print("Данные по выбранному фильтру есть")
            errorSearch.isHidden = true
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredContacts = contacts.filter { contact in
            // Проверка на соответствие поисковому тексту
            return contact.firstName.contains(searchText) ||
            contact.lastName.contains(searchText) ||
            contact.userTag.contains(searchText) ||
            contact.phone.contains(searchText)
        }
        // Обновление таблицы с отфильтрованными результатами
        departmentContactList.reloadData()
        // проверка наличия отфильтрованных данных
        let isSearchEmpty = departmentSearchBar.searchTextField.state.isEmpty
        let isContactListEmpty = filteredContacts.isEmpty
        //если таблица пуста или строка ввода не пустая, то показать ошибку ввода
        errorSearch.isHidden = isContactListEmpty || !isSearchEmpty ? false : true
    }
}

