//
//  ViewController.swift
//  ContactList
//
//  Created by Владимир Есаян on 03.10.2023.
//

import UIKit
import SnapKit

class ContactListViewController: UIViewController {
    
    // MARK: - constants
    private let searchTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // вызов функций
        searchSetup()
    }
    
    private func searchSetup() {
        view.addSubview(searchTextField)
        // скругление поисковой строки
        searchTextField.layer.cornerRadius = 16
        searchTextField.borderStyle = .none
        searchTextField.layer.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.973, alpha: 1).cgColor
        // cоздание иконок для textField
        let searchIcon = UIImageView(image: UIImage(named: "search"))
        let sortIcon = UIImageView(image: UIImage(named: "list-ui-alt"))
        
        // отступ
        // устанавливаем изображение внутри TextField
        searchTextField.leftView = searchIcon
        searchTextField.rightView = sortIcon
        
        // режим отображения
        searchTextField.leftViewMode = .always
        searchTextField.rightViewMode = .always
        searchTextField.font = UIFont(name: "Inter-Medium", size: 15)
        // задаем цвет текст в placeholder и текст
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Введи имя, тег, почту...", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.76, green: 0.76, blue: 0.78, alpha: 1)])
        // constraits
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
    }
    
}
