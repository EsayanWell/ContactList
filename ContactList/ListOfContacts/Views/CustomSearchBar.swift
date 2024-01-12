//
//  DepartmentSearchBar.swift
//  ContactList
//
//  Created by Владимир Есаян on 11.10.2023.
//

import Foundation
import UIKit

// протокол для передачи данных между контроллером и customSearchBar
protocol CustomSearchBarDelegate: AnyObject {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar)
}

class CustomSearchBar: UISearchBar {
    // добавляем свойство делегата типа CustomSearchBarDelegate в CustomSearchBar
    weak var searchDelegate: CustomSearchBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        searchSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SearchSetup
    private func searchSetup() {
        // cтиль внешнего вида полосы поиска
        self.searchBarStyle = .minimal
        // задаю placeholder и цвет текста из Figma
        self.searchTextField.attributedPlaceholder = NSAttributedString(string: "Введи имя, тег, почту ...", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.76, green: 0.76, blue: 0.78, alpha: 1)])
        // задаю радиус текстового поля из Figma
        self.searchTextField.layer.cornerRadius = 16
        // обрезка контента, который выходит за пределы радиуса
        self.searchTextField.clipsToBounds = true
        self.searchTextField.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        self.searchTextField.backgroundColor = UIColor(cgColor: CGColor(red: 0.969, green: 0.969, blue: 0.973, alpha: 1))
        // подписка на delegate
        self.delegate = self
        // изменение иконки "лупы" из Figma
        self.setImage(UIImage(named: "searchLight"), for: .search, state: .normal)
        // создание иконки "опции" из Figma
        self.setImage(UIImage(named: "option"), for: .bookmark, state: .normal)
        // свойства, которое делает кнопку "фильтрация" из Figma видимой
        self.showsBookmarkButton = true
        // изменение кнопки "удалить" из Figma
        self.setImage(UIImage(named: "clear"), for: .clear, state: .normal)
        // изменение кнопки "cancel" на "отмена" из Figma
        // Настраиваем внешний вид кнопки отмены
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Отмена"
        // Настраиваем цвет кнопки отмена
        let cancelButtonAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 0.396, green: 0.204, blue: 1, alpha: 1),
            .font: UIFont.systemFont(ofSize: 16)]
        // настройка кнопки отмена
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(cancelButtonAttributes, for: .normal)
    }
}

extension CustomSearchBar: UISearchBarDelegate {
    // MARK: - UISearchBarDelegate
    
    // функция, реагирующая на изменение текста в поисковой строке
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // вызов делегата
        searchDelegate?.searchBar(searchBar, textDidChange: searchText)
        // если не вставить сюда, то при повторном использовании строки не появляются
        self.setImage(UIImage(named: "searchDark"), for: .search, state: .normal)
        self.showsCancelButton = true
    }
    
    // MARK: - TextDidBeginEditing
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.showsCancelButton = true
        self.setImage(UIImage(named: "searchDark"), for: .search, state: .normal)
        self.showsBookmarkButton = false
        self.placeholder = ""
        // изменение цвета курсора на заданный из Figma
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.tintColor = UIColor(red: 0.396, green: 0.204, blue: 1, alpha: 1)
        }
    }
    
    // MARK: - TextDidEndEditing
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.showsCancelButton = true
    }
    
    // MARK: - CancelButtonClicked
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.showsCancelButton = false
        self.setImage(UIImage(named: "searchLight"), for: .search, state: .normal)
        self.showsBookmarkButton = true
        self.placeholder = "Введи имя, тег, почту ..."
    }
    
    // MARK: - BookmarkButtonClicked
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        // вызов делегата
        searchDelegate?.searchBarBookmarkButtonClicked(searchBar)
    }
}
