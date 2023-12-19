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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for subview in self.view.subviews {
            print("Subview: \(subview) Frame: \(subview.frame)")
        }
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
            // Создается экземпляр DateFormatter для работы с датами
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            // исходный формат
            dateFormatter.dateFormat = "yyyy-MM-dd"
            // изменение исходного формата
            if let birthDate = dateFormatter.date(from: contactDetail.birthday) {
                dateFormatter.dateFormat = "d MMMM yyyy"
                //
                let age = Calendar.current.dateComponents([.year], from: birthDate, to: Date()).year ?? 0
                let ageString: String
                // проверка для выбора год/года/лет в зависимости от возраста
                switch age {
                case 1, 21, 31, 41, 51, 61, 71, 81, 91, 101:
                    ageString = "\(age) год"
                case 2...4, 22...24, 32...34, 42...44, 52...54, 62...64, 72...74, 82...84, 92...94, 102...104:
                    ageString = "\(age) года"
                default:
                    ageString = "\(age) лет"
                }
                // присваиваем отформатированную дату
                let formattedDate = dateFormatter.string(from: birthDate)
                userBirth.profileAge.text = ageString
                userBirth.profileDateOfBirth.text = formattedDate
            } else {
                print("Invalid date format")
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
        print("кнопка тут, но ее не видно")
    }
    
    // обработчик нажатия на cтрелку
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
        print("нажал!")
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
