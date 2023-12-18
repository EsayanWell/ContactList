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
class UserDateOfBirthView: UIView {
    // MARK: - Constants
    var profileDateOfBirth = UILabel()
    let profileAge = UILabel()
    let profileStarImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // MARK: - sets
        setupViews()
        configureProfileDateOfBirth()
        configureProfileAge()
        configureProfileStarImage()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(profileDateOfBirth)
        addSubview(profileAge)
        addSubview(profileStarImage)
        backgroundColor = .white
    }
    
    // MARK: - Configures
    // функция выполняет задачу обновления интерфейсных элементов на экране информацией из объекта Contact, переданного в качестве параметра
    func configure(contacts: ContactData) {
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
    }
    
    func configureProfileDateOfBirth() {
        profileDateOfBirth.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        profileDateOfBirth.font = UIFont(name: "Inter-Medium", size: 16)
    }
    
    func configureProfileAge() {
        profileAge.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
        profileAge.font = UIFont(name: "Inter-Medium", size: 16)
    }
    
    func configureProfileStarImage() {
        profileStarImage.clipsToBounds = true
        profileStarImage.contentMode = .scaleAspectFill
        profileStarImage.image = UIImage(named: "star")
    }
    
    // MARK: - setConstraints
    private func setConstraints() {
        profileStarImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        profileDateOfBirth.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(profileStarImage.snp.trailing).offset(12)
        }
        
        profileAge.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
