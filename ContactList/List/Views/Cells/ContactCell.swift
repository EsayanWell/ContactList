//
//  ContactCell.swift
//  ContactList
//
//  Created by Владимир Есаян on 16.10.2023.
//

import UIKit
import SnapKit


class ContactCell: UITableViewCell {
    
     //let profilePhoto = UIImageView()
     let profileFirstName = UILabel()
     let profileLastName = UILabel()
     let profilePosition = UILabel()
     let profileUserTag = UILabel()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // MARK: - sets
        //configureProfilePhoto()
        configureProfileFirstName()
        configureProfileLastName()
        configurProfilePosition()
        configurProfileUserTag()
        setupViews()
        setConstraits()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
       // addSubview(profilePhoto)
        addSubview(profileFirstName)
        addSubview(profileLastName)
        addSubview(profilePosition)
        addSubview(profileUserTag)
        backgroundColor = .blue
    }
    
    // функция выполняет задачу обновления интерфейсных элементов на экране информацией из объекта Contact, переданного в качестве параметра
//    func set(contacts: Contact) {
//        //profilePhoto.image = contacts.avatarURL
//        profileFirstName.text = contacts.firstName
//        profileLastName.text = contacts.lastName
//        profilePosition.text = contacts.position
//        profileUserTag.text = contacts.userTag
//    }
    
    // MARK : - Configures
    
//    func configureProfilePhoto() {
//        profilePhoto.layer.cornerRadius = 36
//        profilePhoto.clipsToBounds = true
//        profilePhoto.contentMode = .scaleAspectFill
//    }
    
    // настройки надписи firstName
    func configureProfileFirstName() {
        // цвет текста
        profileFirstName.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        // шрифт
        profileFirstName.font = UIFont(name: "Inter-Medium", size: 16)
    }
    
    // настройки надписи lastName
    func configureProfileLastName() {
        // цвет текста
        profileLastName.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        // шрифт
        profileLastName.font = UIFont(name: "Inter-Medium", size: 16)
    }
    
    // настройки надписи Department
    func configurProfilePosition() {
        // цвет текста
        profilePosition.textColor = UIColor(red: 0.333, green: 0.333, blue: 0.361, alpha: 1)
        // шрифт
        profilePosition.font = UIFont(name: "Inter-Regular", size: 13)
    }
    
    // настройки надписи Email
    func configurProfileUserTag() {
        // цвет текста
        profileUserTag.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
        // шрифт
        profileUserTag.font = UIFont(name: "Inter-Medium", size: 14)
    }
    
    // MARK: - setConstraits
    private func setConstraits() {
//        profilePhoto.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(6)
//            make.bottom.equalToSuperview().offset(-6)
//            make.leading.equalToSuperview()
//            make.height.width.equalTo(72)
//        }
        
        profileFirstName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(160)
            make.height.equalTo(20)
        }
        
        profileLastName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalTo(profileFirstName.snp.trailing)
            make.height.equalTo(20)
        }
        
        profilePosition.snp.makeConstraints { make in
            make.top.equalTo(profileFirstName.snp.bottom).offset(3)
            make.leading.equalTo(profileFirstName.snp.leading)
            make.height.equalTo(16)
        }
        profileUserTag.snp.makeConstraints { make in
            make.bottom.equalTo(profileFirstName.snp.bottom)
            make.leading.equalTo(profileLastName.snp.trailing).offset(4)
        }
    }
}
