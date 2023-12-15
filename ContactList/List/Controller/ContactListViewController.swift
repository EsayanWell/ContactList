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
    private let departmentSearchBar = CustomSearchBar()
    private var contacts = [ContactData]()
    private let dataRefreshControl = UIRefreshControl()
    private var filteredContacts = [ContactData]()
    private let departmentContactList = VerticalContactTableView()
    private let errorReload = ErrorLoadView()
    private var errorSearch = ErrorSearchView()
    private let identifier = "ContactCell"
    private var selectedDepartment: Departments = .all
    private var currentSortingType: SortingType = .byBirthday
    
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
        
        // MARK: - Set constraints
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
    
    // MARK: - Error reload Setup
    // ошибка загрузки
    private func errorReloadSetup(){
        errorReload.tryRequestButton.addTarget(self, action: #selector(updateRequest), for: .touchUpInside)
    }
    
    @objc func updateRequest() {
        print("Try to send request again")
        fetchContactData()
    }
    
    // MARK: - Error View visibility
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
    
    // MARK: - Setup pull to refresh
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
                    self.currentSortingType = .alphabetically
                case .failure(let networkError):
                    print("Failure: \(networkError)")
                    self.errorReload.isHidden = false
                    self.errorViewToggleVisibility(isHidden: true)
                }
            }
        }
    }
}

// MARK: - Extensions for VerticalContactTableView and DepartmentSearchBar
extension ContactListViewController: UITableViewDelegate, UITableViewDataSource, FilterDelegate, CustomSearchBarDelegate, DataSortingDelegate {
    
    // MARK: - Extensions for UITableView
    // функция для отображения количества строк на экране
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContacts.count
    }
    
    // настройка ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ContactCell
        let contact = filteredContacts[indexPath.row]
        cell.configure(contacts: contact)
        // Проверяем, выбран ли фильтр по дате рождения
        switch currentSortingType {
        case.alphabetically:
            cell.profileDateOfBirth.isHidden = true
        case.byBirthday:
            cell.profileDateOfBirth.isHidden = false
        }
        return cell
    }
    
    // Создание header для UITableView
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //создание экземпляра DateFormatter для работы с датами и установка формата даты
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        // Проверяем, что section находится в пределах допустимых значений для массива filteredContacts
        guard section < filteredContacts.count else {
            return nil
        }
        //  получаем контакт на текущем индексе section из массива filteredContacts
        let contact = filteredContacts[section]
        // попытка преобразовать дату дня рождения
        guard let birthdayDate = dateFormatter.date(from: contact.birthday) else {
            return nil
        }
        // получение текущего календаря
        let calendar = Calendar.current
        // получение текущего года
        let currentYear = calendar.component(.year, from: Date())
        // получение года дня рождения контакта
        let birthdayYear = calendar.component(.year, from: birthdayDate)
        // Если день рождения уже прошел в этом году
        if birthdayDate < Date() {
            return "\(currentYear + 1)"
        } else {
            return "\(currentYear)"
        }
    }
    // Настройка надписи header и установка кастомной view
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CustomHeaderView(frame: CGRect(x: 0, y: 0, width: 328, height: 20))
        headerView.backgroundColor = .white
        headerView.yearLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        // чтобы header появлялся только в случае выбора сортировки по дате рождения
        switch currentSortingType {
        case.alphabetically:
            headerView.isHidden = true
        case.byBirthday:
            headerView.isHidden = false
        }
        return headerView
    }
    
    // настройка видимости header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Проверяем, что section находится в пределах допустимых значений для массива filteredContacts
        if section >= filteredContacts.count {
            return 0 // Если нет, то возвращаем высоту 0
        }
        return 20 // Устанавливаем желаемую высоту заголовка
    }
    
    // MARK: - Extensions for UICollectionView
    func didSelectFilter(at indexPath: IndexPath, selectedData: Departments) {
        selectedDepartment = selectedData
        // фильтрация данных, отображаемых на экране
        if selectedDepartment == .all {
            filteredContacts = contacts
            filteredContacts.sort {$0.firstName < $1.firstName}
            print("Выбран фильтр Все")
        } else {
            filteredContacts = contacts.filter { $0.department == selectedDepartment }
            filteredContacts.sort {$0.firstName < $1.firstName}
            print("Выбран фильтр \(selectedDepartment)")
        }
        // обновление экрана при наличии данных по тому или иному департаменту
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
    
    // MARK: - Extensions for UISearchBar
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
    
    // MARK: - searchBarBookmarkButtonClicked (переход на SortingViewController)
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        // Открываем bottom sheet
        let secondVC = SortingViewController(initialSortingType: currentSortingType)
        secondVC.sortingDelegate = self
        let navVC = UINavigationController(rootViewController: secondVC)
        if let sheet = navVC.sheetPresentationController {
            // размеры
            sheet.detents = [.medium(), .large()]
        }
        navigationController?.present(navVC, animated: true)
        print ("BookMark is clicked")
    }
    
    // MARK: - Sorting data
    func applySorting(_ sortingType: SortingType) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Укажите здесь формат вашей даты рождения
        //let today = Date()
        switch sortingType {
        case .alphabetically:
            // Сортировка по алфавиту
            filteredContacts.sort {$0.firstName < $1.firstName}
            departmentContactList.reloadData()
            currentSortingType = .alphabetically
            print("sorting data alphabetically")
        case .byBirthday:
            // Отсортируем массив людей по дате рождения, начиная с самой близкой к сегодняшнему дню
            filteredContacts = filteredContacts.sorted {
                let dateComponents1 = Calendar.current.dateComponents([.month, .day], from: dateFormatter.date(from: $0.birthday)!)
                let dateComponents2 = Calendar.current.dateComponents([.month, .day], from: dateFormatter.date(from: $1.birthday)!)
                // Сравниваем только месяцы и дни, игнорируя год
                if dateComponents1.month! < dateComponents2.month! {
                    return true
                } else if dateComponents1.month! == dateComponents2.month! && dateComponents1.day! < dateComponents2.day! {
                    return true
                } else {
                    return false
                }
            }
            currentSortingType = .byBirthday
            departmentContactList.reloadData()
            print("sorting data byBirthday")
        }
    }
}
