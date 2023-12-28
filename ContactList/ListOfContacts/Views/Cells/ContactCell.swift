//
//  ContactCell.swift
//  ContactList
//
//  Created by Владимир Есаян on 16.10.2023.
//

import UIKit
import SnapKit

class ContactCell: UITableViewCell {
    private var photoImageView = UIImageView()
    private let nameLabel = UILabel()
    private let positionLabel = UILabel()
    private let userTagLabel = UILabel()
    var dateOfBirthLabel = UILabel()
    var cellIdentifier: String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(photoImageView)
        addSubview(nameLabel)
        addSubview(positionLabel)
        addSubview(userTagLabel)
        addSubview(dateOfBirthLabel)
        backgroundColor = .white
        // вызов функций
        configurePhotoImageView()
        configureNameLabel()
        configurePositionLabel()
        configureUserTagLabel()
        configureDateOfBirthLabel()
        
        // MARK: - setConstraints
        photoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().offset(-6)
            make.leading.equalToSuperview()
            make.height.width.equalTo(72)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.leading.equalTo(photoImageView.snp.trailing).offset(16)
        }
        positionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(3)
            make.leading.equalTo(nameLabel.snp.leading)
        }
        userTagLabel.snp.makeConstraints { make in
            make.bottom.equalTo(nameLabel.snp.bottom)
            make.leading.equalTo(nameLabel.snp.trailing).offset(4)
        }
        dateOfBirthLabel.snp.makeConstraints { make in
            make.centerY.equalTo(photoImageView.snp.centerY)
            make.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Configures
    // функция выполняет задачу обновления интерфейсных элементов на экране информацией из объекта Contact, переданного в качестве параметра
    func configure(contacts: ContactData) {
        nameLabel.text = contacts.firstName + " " + contacts.lastName
        positionLabel.text = contacts.position
        userTagLabel.text = contacts.userTag
        dateOfBirthLabel.text = contacts.birthday
        // изменение формата даты
        let formattedDate = DateFormat.formatDate(contacts.birthday,
                                                  fromFormat: "yyyy-MM-dd",
                                                  toFormat: "d MMM",
                                                  localeIdentifier: "ru_RU")
        // присвоение нового формата даты
        dateOfBirthLabel.text = formattedDate
        
        // загрузка изображения
        ImageLoader.loadImage(from: contacts.avatarURL) { (image) in
            if let image = image {
                DispatchQueue.main.async {
                    self.photoImageView.image = image
                }
            } else {
                // Обработка ошибки или отсутствия изображения
                print("Ошибка при загрузке данных")
            }
        }
    }
    
    private func configurePhotoImageView() {
        photoImageView.layer.cornerRadius = 36
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .scaleAspectFill
    }
    
    private func configureNameLabel() {
        nameLabel.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        nameLabel.font = UIFont(name: "Inter-Medium", size: 16)
    }
        
    private func configurePositionLabel() {
        positionLabel.textColor = UIColor(red: 0.333, green: 0.333, blue: 0.361, alpha: 1)
        positionLabel.font = UIFont(name: "Inter-Regular", size: 13)
    }
    
    private func configureUserTagLabel() {
        userTagLabel.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
        userTagLabel.font = UIFont(name: "Inter-Medium", size: 14)
    }
    
    private func configureDateOfBirthLabel() {
        dateOfBirthLabel.textColor = UIColor(red: 0.333, green: 0.333, blue: 0.361, alpha: 1)
        dateOfBirthLabel.font = UIFont(name: "Inter-Regular", size: 15)
    }
}
