//
//  UserProfileViewController.swift
//  ContactList
//
//  Created by Владимир Есаян on 18.12.2023.
//

import Foundation
import UIKit
import SnapKit

class UserProfileViewController: UIViewController {
    let userProfile = UserProfileView()
    let userBirth = UserDateOfBirthView()
    let userPhoneNumber = UserPhoneNumberView()
    var contactDetail: ContactData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        appropriationData()
        setConstraints()
        backButtonSetup()
    }
    
    // MARK: - loadingView
    func appropriationData() {
        if let contactDetail = contactDetail {
            // Загрузка фотографии из URL через URLSession
            if let imageURL = URL(string: contactDetail.avatarURL) {
                let session = URLSession.shared
                let task = session.dataTask(with: imageURL) { (data, response, error) in
                    if let error = error {
                        print("Ошибка при загрузке данных: \(error)")
                        return
                    }
                    if let data = data {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self.userProfile.profilePhoto.image = image
                            }
                        }
                    }
                }
                task.resume()
            }
            // присвоение данных
            userProfile.profileFirstName.text = contactDetail.firstName
            userProfile.profileLastName.text = contactDetail.lastName
            userProfile.profileUserTag.text = contactDetail.userTag
            userProfile.profilePosition.text = contactDetail.position
            userBirth.profileDateOfBirth.text = contactDetail.birthday
            userPhoneNumber.profilePhoneNumber.text = contactDetail.phone
            userBirth.profileDateOfBirth.text = contactDetail.birthday
            // изменение формата даты
            let dateFormatter = DateFormatter()
            // установка формата для парсинга даты
            dateFormatter.dateFormat = "yyyy-MM-dd"
            // проверка парсинга
            if let birthDate = dateFormatter.date(from: contactDetail.birthday),
               let age = Calendar.current.dateComponents([.year], from: birthDate, to: Date()).year {
                var ageString = String(age)
                // Проверяем последнюю цифру в возрасте
                if let lastDigit = ageString.last {
                    // Проверяем числовые значения последней цифры
                    switch lastDigit {
                    case "1":
                        if age != 11 { // Исключаем исключение для числа 11 (11 лет)
                            ageString += " год"
                        }
                    case "2", "3", "4":
                        if age != 12 && age != 13 && age != 14 {
                            ageString += " года"
                        }
                    default:
                        ageString += " лет"
                    }
                }
                userBirth.profileAge.text = ageString
                print(ageString)
            } else {
                print("Ошибка при вычислении возраста")
            }
        }
    }
    // MARK: - setupViews
    private func setupViews() {
        // addSubviews
        view.addSubview(userProfile)
        view.addSubview(userBirth)
        view.addSubview(userPhoneNumber)
        view.backgroundColor = .white
    }
    
    // MARK: - backButtonSetup
    func backButtonSetup() {
        let backButton = UIBarButtonItem(image: UIImage(named: "Left"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonTapped))
        backButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton
    }
    
    // обработчик нажатия на cтрелку
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - setConstraints
    private func setConstraints() {
        userProfile.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
            make.leading.trailing.centerX.equalToSuperview()
            make.height.equalTo(184)
        }
        userBirth.snp.makeConstraints { make in
            make.top.equalTo(userProfile.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(60)
        }
        userPhoneNumber.snp.makeConstraints { make in
            //make.centerY.equalTo(userProfile)
            make.top.equalTo(userBirth.snp.bottom).offset(6)
            make.leading.equalTo(userBirth)
            make.trailing.equalTo(userBirth)
            make.height.equalTo(60)
        }
    }
}
