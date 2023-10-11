//
//  ViewController.swift
//  ContactList
//
//  Created by Владимир Есаян on 03.10.2023.
//

import UIKit
import SnapKit

class ContactListViewController: UIViewController {
    
    // MARK: - Constants
    private let searchBar = UISearchBar()
    private let departmentTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // скрываю NavigationBar
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = .white
        // вызов функций
        searchSetup()
    }
    // MARK: - SearchSetup
    
    private func searchSetup() {
        view.addSubview(searchBar)
        // cтиль внешнего вида полосы поиска
        searchBar.searchBarStyle = .minimal
        // задаю placeholder и цвет текста из Figma
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Введи имя, тег, почту ...", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.76, green: 0.76, blue: 0.78, alpha: 1)])
        // задаю радиус текстового поля из Figma
        searchBar.searchTextField.layer.cornerRadius = 16
        // обрезка контента, который выходит за пределы радиуса
        searchBar.searchTextField.clipsToBounds = true
        // цвет текстового поля из Figma
        searchBar.searchTextField.backgroundColor = UIColor(cgColor: CGColor(red: 0.969, green: 0.969, blue: 0.973, alpha: 1))
        searchBar.delegate = self
        searchBar.showsBookmarkButton = false
        // изменение иконки "лупы" из Figma
        let searchIcon = UIImage(named: "searchLight")
        searchBar.setImage(searchIcon, for: .search, state: .normal)
        // создание иконки "опции" из Figma
        let filterIcon = UIImage(named: "option")
        searchBar.setImage(filterIcon, for: .bookmark, state: .normal)
        // изменение кнопки "удалить" из Figma
        let clearIcon = UIImage(named: "clear")
        searchBar.setImage(clearIcon, for: .clear, state: .normal)
        // изменение кнопки "cancel" на "отмена" из Figma
        // Настраиваем внешний вид кнопки отмены
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Отмена"
        // Настраиваем цвет кнопки отмена
        let cancelButtonAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 0.396, green: 0.204, blue: 1, alpha: 1),
            .font: UIFont.systemFont(ofSize: 16)]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(cancelButtonAttributes, for: .normal)
        
        // настройка расположения на экране
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
    }
}

// MARK: - Extension for UISearchBar

extension ContactListViewController: UISearchBarDelegate {
    
    // функция, реагирующая на начало ввода данных
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        searchBar.setImage(UIImage(named: "searchDark"), for: .search, state: .normal)
        searchBar.showsBookmarkButton = false
        searchBar.placeholder = ""
    }
    
    // функция, реагирующая на окончание ввода данных
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    // функция, реагирующая на нажатие кнопки "отмена"
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.setImage(UIImage(named: "searchLight"), for: .search, state: .normal)
        searchBar.showsBookmarkButton = true
        searchBar.placeholder = "Введи имя, тег, почту ..."
    }
    
    // функция, которая запускается при изменении текста
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.setImage(UIImage(named: "searchDark"), for: .search, state: .normal)
        searchBar.showsCancelButton = true
    }
}
