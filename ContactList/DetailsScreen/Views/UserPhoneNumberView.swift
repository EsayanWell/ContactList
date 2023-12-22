//
//  CustomErrorView.swift
//  ContactList
//
//  Created by Владимир Есаян on 08.11.2023.
//
import Foundation
import UIKit
import SnapKit

// MARK: - Create UserPhoneNumberView
class UserPhoneNumberView: UIView {
    // MARK: - Constants
    let numberLabel = UILabel()
    let phoneImageView = UIImageView()
    // замыкание, которое не принимает аргументы и не возвращает никаких значений (Void).
    var tapPhoneHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(numberLabel)
        addSubview(phoneImageView)
        backgroundColor = .white
        // вызов функций
        configureProfilePhoneNumberLabel()
        configureProfilePhoneImage()
        
        // MARK: - setConstraints
        phoneImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
        numberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(phoneImageView)
            make.leading.equalTo(phoneImageView.snp.trailing).offset(12)
        }
    }
    
    private func configureProfilePhoneNumberLabel() {
        numberLabel.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        numberLabel.font = UIFont(name: "Inter-Medium", size: 16)
        numberLabel.isUserInteractionEnabled = true
        numberLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(phoneIconTapped)))
    }
    
    private func configureProfilePhoneImage() {
        phoneImageView.clipsToBounds = true
        phoneImageView.contentMode = .scaleAspectFill
        phoneImageView.image = UIImage(named: "phone")
        phoneImageView.isUserInteractionEnabled = true
        phoneImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(phoneIconTapped)))
    }
    
    @objc private func phoneIconTapped() {
        // Обработка нажатия на иконку телефона
        tapPhoneHandler?()
    }
}
