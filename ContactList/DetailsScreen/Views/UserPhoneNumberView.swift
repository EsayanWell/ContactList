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
    let profilePhoneNumber = UILabel()
    let profilePhoneImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // MARK: - sets
        setupViews()
        configureProfilePhoneNumber()
        configureProfilePhoneImage()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(profilePhoneNumber)
        addSubview(profilePhoneImage)
        backgroundColor = .white
    }
    
    private func configureProfilePhoneNumber() {
        profilePhoneNumber.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        profilePhoneNumber.font = UIFont(name: "Inter-Medium", size: 16)
    }
    
    private func configureProfilePhoneImage() {
        profilePhoneImage.clipsToBounds = true
        profilePhoneImage.contentMode = .scaleAspectFill
        profilePhoneImage.image = UIImage(named: "phone")
    }
    
    // MARK: - setConstraints
    private func setConstraints() {
        profilePhoneImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        profilePhoneNumber.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(profilePhoneImage.snp.trailing).offset(12)
        }
    }
}
