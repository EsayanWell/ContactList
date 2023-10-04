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
       // searchTextField.borderStyle = .roundedRect
        searchTextField.layer.cornerRadius = 16
        //searchTextField.backgroundColor = .white
        // cоздание иконки лупы
        let seacrhIcon = UIImageView(image: UIImage(named: "search"))
        // размер иконки
        seacrhIcon.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        // устанавливаем изображение внутри TextField
        searchTextField.leftView = seacrhIcon
        // режим отображения
        searchTextField.leftViewMode = .unlessEditing
        // задаем цвет текст в placeholder и текст
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Введи имя, тег, почту ...", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.76, green: 0.76, blue: 0.78, alpha: 1)])
        // constraits
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(16) // Примерное смещение слева
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
    }
    
}

