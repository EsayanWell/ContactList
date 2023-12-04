//
//  DepartmentSearchBar.swift
//  ContactList
//
//  Created by Владимир Есаян on 11.10.2023.
//

import Foundation
import UIKit

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
        // цвет текстового поля из Figma
        self.searchTextField.backgroundColor = UIColor(cgColor: CGColor(red: 0.969, green: 0.969, blue: 0.973, alpha: 1))
        // подписка на delegate
        self.delegate = self
        // изменение иконки "лупы" из Figma
        let searchIcon = UIImage(named: "searchLight")
        self.setImage(searchIcon, for: .search, state: .normal)
        // создание иконки "опции" из Figma
        let filterIcon = UIImage(named: "option")
        self.setImage(filterIcon, for: .bookmark, state: .normal)
        // свойства, которое делает кнопку "фильтрация" из Figma видимой
        self.showsBookmarkButton = true
        // изменение кнопки "удалить" из Figma
        let clearIcon = UIImage(named: "clear")
        self.setImage(clearIcon, for: .clear, state: .normal)
        // изменение кнопки "cancel" на "отмена" из Figma
        // Настраиваем внешний вид кнопки отмены
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Отмена"
        // Настраиваем цвет кнопки отмена
        let cancelButtonAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 0.396, green: 0.204, blue: 1, alpha: 1),
            .font: UIFont.systemFont(ofSize: 16)]
        // настройка кнопки отмена
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(cancelButtonAttributes, for: .normal)
        
        // настройка кнопки bookMark
        
    }
}

extension CustomSearchBar: UISearchBarDelegate {
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // вызов делегата 
        searchDelegate?.searchBar(searchBar, textDidChange: searchText)
        // если не вставить сюда, то при повторном использовании строки не появляются
        self.setImage(UIImage(named: "searchDark"), for: .search, state: .normal)
        self.showsCancelButton = true
    }
    
    // функция, реагирующая на начало ввода данных
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
    
    // функция, реагирующая на окончание ввода данных
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.showsCancelButton = true
    }
    
    // функция, реагирующая на нажатие кнопки "отмена"
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.showsCancelButton = false
        self.setImage(UIImage(named: "searchLight"), for: .search, state: .normal)
        self.showsBookmarkButton = true
        self.placeholder = "Введи имя, тег, почту ..."
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        // вызов делегата
        searchDelegate?.searchBarBookmarkButtonClicked(searchBar)
    }
}
