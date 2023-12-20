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
    // MARK: - Constants
    private let userProfile = UserProfileView()
    private let userBirth = UserDateOfBirthView()
    private let userPhoneNumber = UserPhoneNumberView()
    var contactDetail: ContactData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        appropriationData()
        backButtonSetup()
        phoneTapRecognizer()
        makeCall()
        setConstraints()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - setupViews
    private func setupViews() {
        view.addSubview(userProfile)
        view.addSubview(userBirth)
        view.addSubview(userPhoneNumber)
        view.backgroundColor = .white
    }
    
    // MARK: - loadingView
    private func appropriationData() {
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
    
    // MARK: - backButtonSetup
    private func backButtonSetup() {
        let backButton = UIBarButtonItem(image: UIImage(named: "shevron"),
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
    
    private func phoneTapRecognizer() {
        // обработчик нажатия на номер и иконку вызова
        let tapPhoneIcon = UITapGestureRecognizer(target: self, action: #selector(handlePhoneTap))
        let tapPhoneNumber = UITapGestureRecognizer(target: self, action: #selector(handlePhoneTap))
        userPhoneNumber.profilePhoneNumber.isUserInteractionEnabled = true
        userPhoneNumber.profilePhoneImage.isUserInteractionEnabled = true
        userPhoneNumber.profilePhoneNumber.addGestureRecognizer(tapPhoneIcon)
        userPhoneNumber.profilePhoneImage.addGestureRecognizer(tapPhoneNumber)
    }
    
    // нажатие на номер
    @objc private func handlePhoneTap() {
        // nil для того, чтобы не было дополнительных строк
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // проверка на nil
        let phoneNumberTitle = userPhoneNumber.profilePhoneNumber.text ?? "There's no number"
        let callAction = UIAlertAction(title: "\(phoneNumberTitle)", style: .default) { (_) in
            self.makeCall()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        // изменение цвета кнопок по ТЗ
        callAction.setValue(UIColor(red: 0.198, green: 0.198, blue: 0.198, alpha: 1), forKey: "titleTextColor")
        cancelAction.setValue(UIColor(red: 0.198, green: 0.198, blue: 0.198, alpha: 1), forKey: "titleTextColor")
        alertController.addAction(callAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - makeCall
    private func makeCall() {
        // проверка, что номер корректный
        guard let phoneNumber = userPhoneNumber.profilePhoneNumber.text,
              let url = URL(string: "tel://\(phoneNumber)") else {
            print("Некорректный номер телефона")
            return
        }
        // может ли устройство открыть указанный URL
        if UIApplication.shared.canOpenURL(url) {
            // Если устройство может открыть URL, вызывается метод open у объекта UIApplication для начала звонка. Пустой словарь [:] передается в качестве параметра options.
            UIApplication.shared.open(url, options: [:], completionHandler: { success in
                if success {
                    print("Идет вызов")
                } else {
                    print("Не удалось совершить звонок")
                }
            })
        } else {
            // Если устройство не может открыть URL для звонка
            print("Устройство не может осуществить звонок")
        }
    }
    
    // MARK: - setConstraints
    private func setConstraints() {
        userProfile.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
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
            make.top.equalTo(userBirth.snp.bottom).offset(6)
            make.leading.equalTo(userBirth)
            make.trailing.equalTo(userBirth)
            make.height.equalTo(60)
        }
    }
}
