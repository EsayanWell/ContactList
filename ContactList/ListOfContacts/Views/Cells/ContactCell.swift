//
//  ContactCell.swift
//  ContactList
//
//  Created by Владимир Есаян on 16.10.2023.
//

import UIKit
import SnapKit

class ContactCell: UITableViewCell {
    private var profilePhoto = UIImageView()
    private let profileFirstName = UILabel()
    private let profileLastName = UILabel()
    private let profilePosition = UILabel()
    private let profileUserTag = UILabel()
    var profileDateOfBirth = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // FunctionsCall
        setupViews()
        configureProfilePhoto()
        configureProfileFirstName()
        configureProfileLastName()
        configureProfilePosition()
        configureProfileUserTag()
        configureProfileDateOfBirth()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(profilePhoto)
        addSubview(profileFirstName)
        addSubview(profileLastName)
        addSubview(profilePosition)
        addSubview(profileUserTag)
        addSubview(profileDateOfBirth)
        backgroundColor = .white
    }
    
    // MARK: - Configures
    // функция выполняет задачу обновления интерфейсных элементов на экране информацией из объекта Contact, переданного в качестве параметра
    func configure(contacts: ContactData) {
        profileFirstName.text = contacts.firstName
        profileLastName.text = contacts.lastName
        profilePosition.text = contacts.position
        profileUserTag.text = contacts.userTag
        profileDateOfBirth.text = contacts.birthday
        // изменение формата даты
        // Создается экземпляр DateFormatter для работы с датами
        let dateFormatter = DateFormatter()
        // установка формата для парсинга даты
        dateFormatter.dateFormat = "yyyy-MM-dd"
        // проверяется, удалось ли распарсить данные
        if let birthDate = dateFormatter.date(from: contacts.birthday) {
            dateFormatter.locale = Locale(identifier: "ru_RU")
            // задание определенного формата
            dateFormatter.dateFormat = "d MMM"
            // дата форматируется в строку в новом формате
            let formattedDate = dateFormatter.string(from: birthDate)
            // присваиваем отформатированные данные для отображения
            profileDateOfBirth.text = formattedDate
        } else {
            print("Invalid date format")
        }
        // Загрузка фотографии из URL через URLSession
        if let imageURL = URL(string: contacts.avatarURL) {
            let session = URLSession.shared
            let task = session.dataTask(with: imageURL) { (data, response, error) in
                if let error = error {
                    print("Ошибка при загрузке данных: \(error)")
                    return
                }
                if let data = data {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.profilePhoto.image = image
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    private func configureProfilePhoto() {
        profilePhoto.layer.cornerRadius = 36
        profilePhoto.clipsToBounds = true
        profilePhoto.contentMode = .scaleAspectFill
    }
    
    private func configureProfileFirstName() {
        profileFirstName.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        profileFirstName.font = UIFont(name: "Inter-Medium", size: 16)
    }
    
    private func configureProfileLastName() {
        profileLastName.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        profileLastName.font = UIFont(name: "Inter-Medium", size: 16)
    }
    
    private func configureProfilePosition() {
        profilePosition.textColor = UIColor(red: 0.333, green: 0.333, blue: 0.361, alpha: 1)
        profilePosition.font = UIFont(name: "Inter-Regular", size: 13)
    }
    
    private func configureProfileUserTag() {
        profileUserTag.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
        profileUserTag.font = UIFont(name: "Inter-Medium", size: 14)
    }
    
    private func configureProfileDateOfBirth() {
        profileDateOfBirth.textColor = UIColor(red: 0.333, green: 0.333, blue: 0.361, alpha: 1)
        profileDateOfBirth.font = UIFont(name: "Inter-Regular", size: 15)
    }
    
    // MARK: - setConstraints
    private func setConstraints() {
        profilePhoto.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().offset(-6)
            make.leading.equalToSuperview()
            make.height.width.equalTo(72)
        }
        profileFirstName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.leading.equalTo(profilePhoto.snp.trailing).offset(16)
        }
        profileLastName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.leading.equalTo(profileFirstName.snp.trailing).offset(4)
        }
        profilePosition.snp.makeConstraints { make in
            make.top.equalTo(profileFirstName.snp.bottom).offset(3)
            make.leading.equalTo(profileFirstName.snp.leading)
        }
        profileUserTag.snp.makeConstraints { make in
            make.bottom.equalTo(profileFirstName.snp.bottom)
            make.leading.equalTo(profileLastName.snp.trailing).offset(4)
        }
        profileDateOfBirth.snp.makeConstraints { make in
            make.centerY.equalTo(profilePhoto.snp.centerY)
            make.trailing.equalToSuperview()
        }
    }
}
