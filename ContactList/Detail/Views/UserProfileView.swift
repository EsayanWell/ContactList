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
    let profileFirstName = UILabel()
    let profileLastName = UILabel()
    var profilePosition = UILabel()
    var profileUserTag = UILabel()
    let containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // MARK: - sets
        setupViews()
        configureProfilePhoto()
        configureProfileFirstName()
        configureProfileLastName()
        configureProfilePosition()
        configureProfileUserTag()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(profilePhoto)
        containerView.addSubview(profileFirstName)
        containerView.addSubview(profileLastName)
        containerView.addSubview(profileUserTag)
        addSubview(profilePosition)
        addSubview(containerView)
        backgroundColor = .white
    }
    
    // настройка фото профиля
    func configureProfilePhoto() {
        profilePhoto.layer.cornerRadius = 52
        profilePhoto.clipsToBounds = true
        profilePhoto.contentMode = .scaleAspectFill
    }
    
    // настройки надписи Name
    func configureProfileFirstName() {
        profileFirstName.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        profileFirstName.font = UIFont(name: "Inter-Bold", size: 24)
    }
    
    func configureProfileLastName() {
        profileLastName.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        profileLastName.font = UIFont(name: "Inter-Bold", size: 24)
    }
    
    // настройки надписи Department
    func configureProfilePosition() {
        profilePosition.textColor = UIColor(red: 0.333, green: 0.333, blue: 0.361, alpha: 1)
        profilePosition.font = UIFont(name: "Inter-Regular", size: 13)
    }
    
    func configureProfileUserTag() {
        profileUserTag.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
        profileUserTag.font = UIFont(name: "Inter-Regular", size: 17)
    }
    
    // MARK: - setConstraints
    private func setConstraints() {
        profilePhoto.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.width.equalTo(104)
        }
        
        profileFirstName.snp.makeConstraints { make in
            make.top.equalTo(containerView)
            make.leading.equalTo(containerView)
        }
        
        profileLastName.snp.makeConstraints { make in
            make.centerY.equalTo(profileFirstName.snp.centerY)
            make.leading.equalTo(profileFirstName.snp.trailing).offset(4)
        }
        
        profileUserTag.snp.makeConstraints { make in
            make.centerY.equalTo(profileFirstName.snp.centerY)
            make.leading.equalTo(profileLastName.snp.trailing).offset(4)
            make.trailing.equalTo(containerView.snp.trailing).offset(-4)
        }
        
        profilePosition.snp.makeConstraints { make in
            make.top.equalTo(profileFirstName.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        // Установка констрейнтов для контейнера относительно другого объекта
        containerView.snp.makeConstraints { make in
            make.centerX.equalTo(profilePhoto)
            make.top.equalTo(profilePhoto.snp.bottom).offset(24)
        }
    }
}
