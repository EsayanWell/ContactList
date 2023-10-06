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
    private let searchTextField = CustomTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // скрываю NavigationBar
        navigationController?.setNavigationBarHidden(true, animated: true)

        view.backgroundColor = .white
        // вызов функций
        searchSetup()
    }
    
    private func searchSetup() {
        searchTextField.layer.cornerRadius = 16
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Введи имя, тег, почту...", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.76, green: 0.76, blue: 0.78, alpha: 1)])
        searchTextField.font = UIFont(name: "Inter-Medium", size: 15)
        searchTextField.layer.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.973, alpha: 1).cgColor
        // cоздание иконок для textField
        let searchIcon = UIImageView(image: UIImage(named: "search"))
        let sortIcon = UIImageView(image: UIImage(named: "list-ui-alt"))
        searchIcon.contentMode = .center
        sortIcon.contentMode = .center
        // устанавливаем изображение внутри TextField
        searchTextField.rightView = sortIcon
        searchTextField.leftView = searchIcon
        // режим отображения
        searchTextField.leftViewMode = .always
        searchTextField.rightViewMode = .always
    
        view.addSubview(searchTextField)
        // constraits
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
    }
    
}
