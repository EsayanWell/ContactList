//
//  ViewController.swift
//  ContactList
//
//  Created by Владимир Есаян on 03.10.2023.
//
import Foundation
import UIKit
import SnapKit



class ContactListViewController: UIViewController {
    
    // MARK: - Constants
    private let departmentMenuCollectionView = HorizontalMenuCollectionView()
    private let departmentSeacrhBar = CustomSearchBar()
    let departmentContactList = VerticalContactTableView()
    private let errorReload = ErrorLoadView()
    var errorSearch = ErrorSearchView()
    private let identifier = "ContactCell"
    // pull-to-refresh
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
        // подписка на delegate
        departmentMenuCollectionView.filterDelegate = self
        departmentSeacrhBar.delegate = self
        errorSearch.isHidden = true
        
    }
    
    // MARK: - setupViews
    private func setupViews() {
        view.backgroundColor = .white
        // addSubviews
        view.addSubview(departmentMenuCollectionView)
        view.addSubview(departmentSeacrhBar)
        view.addSubview(departmentContactList)
        view.addSubview(errorReload)
        view.addSubview(errorSearch)
        
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
        departmentSeacrhBar.isHidden = isHidden
        departmentMenuCollectionView.isHidden = isHidden
        departmentContactList.isHidden = isHidden
        
        if isHidden {
            print("Данных в таблице нет")
        } else {
            print("Данные в таблице есть: \(departmentContactList.contacts.count)")
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
                    self.departmentContactList.contacts = decodedContacts
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

// MARK: - extensions for VerticalContactTableView and DepartmentSeacrhBar
extension ContactListViewController: FilterDelegate, UISearchBarDelegate {
    
    // MARK: - filtered data delegate
    func didSelectFilter(at indexPath: IndexPath, selectedData: Departments) {
        
        selectedDepartment = selectedData
        // фильтрация данных, отображаемых на экране
        if selectedDepartment == .all {
            departmentContactList.filteredContacts = departmentContactList.contacts
            print("Выбран фильтр Все")
        } else {
            departmentContactList.filteredContacts = departmentContactList.contacts.filter { $0.department == selectedDepartment }
            print("Выбран фильтр \(selectedDepartment)")
        }
        
        if  departmentContactList.filteredContacts.isEmpty {
            departmentContactList.isHidden = true
            print("Нет данных по выбранному фильтру")
        } else {
            departmentContactList.reloadData()
            departmentContactList.isHidden = false
            print("Данные по выбранному фильтру есть")
            errorSearch.isHidden = true
        }
    }
    
    // MARK: - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        departmentContactList.filteredContacts = departmentContactList.contacts.filter { contact in
            // Проверка на соответствие поисковому тексту
            return contact.firstName.contains(searchText) ||
            contact.lastName.contains(searchText) ||
            contact.userTag.contains(searchText) ||
            contact.phone.contains(searchText)
        }
        // Обновление таблицы с отфильтрованными результатами
        departmentContactList.reloadData()
        // проверка наличия отфильтрованных данных
        let isSearchEmpty = departmentSeacrhBar.searchTextField.state.isEmpty
        let isContactListEmpty = departmentContactList.filteredContacts.isEmpty
        
        if isContactListEmpty || !isSearchEmpty {
            print("Поиск не дал результатов")
            errorSearch.isHidden = false
        } else {
            errorSearch.isHidden = true
        }
        departmentSeacrhBar.setImage(UIImage(named: "searchDark"), for: .search, state: .normal)
        departmentSeacrhBar.showsCancelButton = true
    }
    
    // функция, реагирующая на начало ввода данных
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        departmentSeacrhBar.showsCancelButton = true
        departmentSeacrhBar.setImage(UIImage(named: "searchDark"), for: .search, state: .normal)
        departmentSeacrhBar.showsBookmarkButton = false
        departmentSeacrhBar.placeholder = ""
        // изменение цвета курсора на заданный из Figma
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.tintColor = UIColor(red: 0.396, green: 0.204, blue: 1, alpha: 1)
        }
    }
    
    // функция, реагирующая на окончание ввода данных
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        departmentSeacrhBar.showsCancelButton = true
    }
    
    // функция, реагирующая на нажатие кнопки "отмена"
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        departmentSeacrhBar.showsCancelButton = false
        departmentSeacrhBar.setImage(UIImage(named: "searchLight"), for: .search, state: .normal)
        departmentSeacrhBar.showsBookmarkButton = true
        departmentSeacrhBar.placeholder = "Введи имя, тег, почту ..."
    }
}
