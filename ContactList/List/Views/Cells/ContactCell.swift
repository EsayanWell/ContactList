//
//  ContactCell.swift
//  ContactList
//
//  Created by Владимир Есаян on 16.10.2023.
//

import UIKit
import SnapKit


class ContactCell: UITableViewCell {
    
    private let profilePhoto = UIImageView()
    private let profileName = UILabel()
    private let profileDepartment = UILabel()
    private let profileEmail = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // MARK: - sets
        configureProfilePhoto()
        configurProfileName()
        configurProfileDepartment()
        configurProfileEmail()
        setupViews()
        setConstraits()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(profilePhoto)
        addSubview(profileName)
        addSubview(profileDepartment)
        addSubview(profileEmail)
        backgroundColor = .blue
    }
    
    // функция выполняет задачу обновления интерфейсных элементов на экране информацией из объекта Expense, переданного в качестве параметра
    // функция выполняет задачу обновления интерфейсных элементов на экране информацией из объекта Expense, переданного в качестве параметра
    func set(contactArray: Contact) {
        profilePhoto.image = contactArray.image
        profileName.text = contactArray.name
        profileDepartment.text = contactArray.department
        profileEmail.text = contactArray.nickname
    }
    
    // MARK : - Configures
    
    func configureProfilePhoto() {
        profilePhoto.layer.cornerRadius = 36
        profilePhoto.clipsToBounds = true
        profilePhoto.contentMode = .scaleAspectFill
    }
    
    // настройки надписи Name
    func configurProfileName() {
        // цвет текста
        profileName.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        // шрифт
        profileName.font = UIFont(name: "Inter-Medium", size: 16)
    }
    
    // настройки надписи Department
    func configurProfileDepartment() {
        // цвет текста
        profileDepartment.textColor = UIColor(red: 0.333, green: 0.333, blue: 0.361, alpha: 1)
        // шрифт
        profileDepartment.font = UIFont(name: "Inter-Regular", size: 13)
    }
    
    // настройки надписи Email
    func configurProfileEmail() {
        // цвет текста
        profileEmail.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
        // шрифт
        profileEmail.font = UIFont(name: "Inter-Medium", size: 14)
    }
    
    // MARK: - setConstraits
    private func setConstraits() {
        profilePhoto.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().offset(-6)
            make.leading.equalToSuperview()
            make.height.width.equalTo(72)
        }
        
        profileName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalTo(profilePhoto.snp.trailing).offset(16)
            make.height.equalTo(20)
        }
        
        profileDepartment.snp.makeConstraints { make in
            make.top.equalTo(profileName.snp.bottom).offset(3)
            make.leading.equalTo(profileName.snp.leading)
            make.height.equalTo(16)
        }
        profileEmail.snp.makeConstraints { make in
            make.bottom.equalTo(profileName.snp.bottom)
            make.leading.equalTo(profileName.snp.trailing).offset(4)
            //make.height.equalTo(18)
        }
    }
}
