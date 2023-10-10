//
//  ViewController.swift
//  ContactList
//
//  Created by Владимир Есаян on 03.10.2023.
//

import UIKit
import SnapKit

class ContactListViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - constants
    private let searchBar = UISearchBar()
    private let departmentTavbleView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // скрываю NavigationBar
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = .white
        // вызов функций
        searchSetup()
        
    }
    
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
        
        // cоздание иконки лупы
        let filterIcon = UIImageView(image: UIImage(named: "list-ui-alt"))
        filterIcon.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        filterIcon.contentMode = .scaleAspectFit
        searchBar.searchTextField.rightView = filterIcon
        searchBar.searchTextField.rightViewMode = .always
        //searchBar.clipsToBounds = true
        //searchBar.rightView = searchIcon
        
        //searchBar.showsCancelButton = true
        searchBar.delegate = self
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
    }

}

extension ContactListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//       
//    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
       }


}
