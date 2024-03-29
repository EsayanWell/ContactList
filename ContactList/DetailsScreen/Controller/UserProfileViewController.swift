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
        handlePhoneTapNumber()
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
        loadImage(contactDetail)
        assignData(contactDetail)
        formatAndDisplayDateOfBirth(contactDetail)
        displayAge(contactDetail)
    }
    
    // загрузка изображения
    private func loadImage(_ contactDetail: ContactData) {
        ImageLoader.loadImage(from: contactDetail.avatarURL) { (image) in
            if let image = image {
                DispatchQueue.main.async {
                    self.profileView.photoImageView.image = image
                }
            } else {
                print("Ошибка при загрузке данных")
            }
        }
    }
    
    // присвоение данных
    private func assignData(_ contactDetail: ContactData) {
        profileView.nameLabel.text = contactDetail.firstName + " " + contactDetail.lastName
        profileView.userTagLabel.text = contactDetail.userTag
        profileView.positionLabel.text = contactDetail.position
        phoneNumberView.numberLabel.text = contactDetail.phone
    }
    
    // форматирование даты
    private func formatAndDisplayDateOfBirth(_ contactDetail: ContactData) {
        let formattedDate = DateFormat.formatDate(contactDetail.birthday, fromFormat: "yyyy-MM-dd", toFormat: "d MMMM yyyy", localeIdentifier: "ru_RU")
        birthView.dateOfBirthLabel.text = formattedDate
    }
    
    // отображение возраста
    private func displayAge(_ contactDetail: ContactData) {
        let formatAgeString: String = NSLocalizedString("age_years", comment: "Person's age in plural configuration")
        let age = DateFormat.calculateAgeFromDate(contactDetail.birthday, format: "yyyy-MM-dd")
        let resultAgeString = String.localizedStringWithFormat(formatAgeString, age)
        birthView.ageLabel.text = resultAgeString
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
    }
    
    private func handlePhoneTapNumber() {
        // обработчик нажатия на номер телефона
        phoneNumberView.tapPhoneHandler = {
            self.handlePhoneTap()
        }
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
    // проверка корректности номера телефона
    private func validatePhoneNumber() -> String? {
        guard let phoneNumber = phoneNumberView.numberLabel.text else {
            return nil
        }
        return phoneNumber
    }
    
    // открытие URL для осуществления звонка
    private func openCallURL(phoneNumber: String) {
        guard let url = URL(string: "tel://\(phoneNumber)") else {
            print("URL не может быть создан")
            return
        }
        
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
    
    // совершение звонка
    private func makeCall() {
        guard let phoneNumber = validatePhoneNumber() else {
            print("Некорректный номер телефона")
            return
        }
        
        openCallURL(phoneNumber: phoneNumber)
    }
}
