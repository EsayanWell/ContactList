//
//  CustomErrorView.swift
//  ContactList
//
//  Created by Владимир Есаян on 08.11.2023.
//
import Foundation
import UIKit
import SnapKit

// MARK: - Create customViewController
class UserProfileView: UIView {
    // MARK: - Constants
    var profilePhoto = UIImageView()
    let profileName = UILabel()
    let profilePosition = UILabel()
    let profileUserTag = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // MARK: - sets
        setupViews()
        configureProfilePhoto()
        configureProfileName()
        configureProfilePosition()
        configureProfileUserTag()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(profilePhoto)
        addSubview(profileName)
        addSubview(profilePosition)
        addSubview(profileUserTag)
        backgroundColor = .white
    }
    
    // MARK: - Configures
    // функция выполняет задачу обновления интерфейсных элементов на экране информацией из объекта Contact, переданного в качестве параметра
    func configure(contacts: ContactData) {
        profileName.text = contacts.firstName + contacts.lastName
        profilePosition.text = contacts.position
        profileUserTag.text = contacts.userTag
    }
    
    // настройка фото профиля
    func configureProfilePhoto() {
        profilePhoto.layer.cornerRadius = 52
        profilePhoto.clipsToBounds = true
        profilePhoto.contentMode = .scaleAspectFill
    }
    
    // настройки надписи Name
    func configureProfileName() {
        profileName.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        profileName.font = UIFont(name: "Inter-Bold", size: 24)
    }
    
    // настройки надписи Department
    func configureProfilePosition() {
        profilePosition.textColor = UIColor(red: 0.333, green: 0.333, blue: 0.361, alpha: 1)
        profilePosition.font = UIFont(name: "Inter-Regular", size: 13)
    }
    
    // настройки надписи Email
    func configureProfileUserTag() {
        profileUserTag.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
        profileUserTag.font = UIFont(name: "Inter-Regular", size: 17)
    }
    
    
    // MARK: - setConstraints
    private func setConstraints() {
        profilePhoto.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(104)
        }
        
        profileName.snp.makeConstraints { make in
            make.top.equalTo(profilePhoto.snp.bottom).offset(24)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(85)
        }
        
        profileUserTag.snp.makeConstraints { make in
            make.centerX.equalTo(profilePhoto.snp.centerX)
            make.leading.equalTo(profileName.snp.trailing).offset(4)
        }
        
        profilePosition.snp.makeConstraints { make in
            make.top.equalTo(profileName.snp.bottom).offset(12)
            make.centerY.equalTo(profilePhoto.snp.centerY)
            make.bottom.equalToSuperview()
        }
    }
}
