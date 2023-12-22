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
    private let profileView = UserProfileView()
    private let birthView = UserDateOfBirthView()
    private let phoneNumberView = UserPhoneNumberView()
    var contactDetail: ContactData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        backButtonSetup()
        // обработчик нажатия на номер телефона
        phoneNumberView.tapPhoneHandler = {
            self.handlePhoneTap()
        }
    }
    
    // сокрытие navigationController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - setupViews
    private func setupViews() {
        view.addSubview(profileView)
        view.addSubview(birthView)
        view.addSubview(phoneNumberView)
        view.backgroundColor = .white
        // вызов функций
        setupUserProfile()
        
        // MARK: - setConstraints
        profileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(184)
        }
        birthView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(60)
        }
        phoneNumberView.snp.makeConstraints { make in
            make.top.equalTo(birthView.snp.bottom).offset(6)
            make.leading.equalTo(birthView)
            make.trailing.equalTo(birthView)
            make.height.equalTo(60)
        }
    }
    
    // MARK: - loadingView
    private func setupUserProfile() {
        guard let contactDetail = contactDetail else {
            return
        }
        // загрузка изображения
        ImageLoader.loadImage(from: contactDetail.avatarURL) { (image) in
            if let image = image {
                DispatchQueue.main.async {
                    self.profileView.photoImageView.image = image
                }
            } else {
                // Обработка ошибки или отсутствия изображения
                print("Ошибка при загрузке данных")
            }
        }
        
        // присвоение данных
        profileView.nameLabel.text = contactDetail.firstName + " " + contactDetail.lastName
        profileView.userTagLabel.text = contactDetail.userTag
        profileView.positionLabel.text = contactDetail.position
        birthView.dateOfBirthLabel.text = contactDetail.birthday
        phoneNumberView.numberLabel.text = contactDetail.phone
        
        // изменение формата даты для отображения даты рождения
        let formattedDate = DateFormat.formatDate(contactDetail.birthday,
                                                  fromFormat: "yyyy-MM-dd",
                                                  toFormat: "d MMMM yyyy",
                                                  localeIdentifier: "ru_RU")
        
        // отображение возраста
        let age = DateFormat.calculateAgeFromDate(contactDetail.birthday, format: "yyyy-MM-dd")
        let ageString: String
        // Проверка для выбора правильного формата строки в зависимости от возраста
        switch age {
        case 1, 21, 31, 41, 51, 61, 71, 81, 91, 101:
            ageString = String.localizedStringWithFormat(NSLocalizedString("%lld год", comment: ""), age)
        case 2...4, 22...24, 32...34, 42...44, 52...54, 62...64, 72...74, 82...84, 92...94, 102...104:
            ageString = String.localizedStringWithFormat(NSLocalizedString("%lld года", comment: ""), age)
        default:
            ageString = String.localizedStringWithFormat(NSLocalizedString("%lld лет", comment: ""), age)
        }
        birthView.ageLabel.text = ageString
        birthView.dateOfBirthLabel.text = formattedDate
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
    
    private func handlePhoneTap() {
        // nil для того, чтобы не было дополнительных строк
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // проверка на nil
        let phoneNumberTitle = phoneNumberView.numberLabel.text ?? "There's no number"
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
        guard let phoneNumber = phoneNumberView.numberLabel.text,
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
}
