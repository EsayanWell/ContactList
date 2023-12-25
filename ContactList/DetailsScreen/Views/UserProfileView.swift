//
//  CustomErrorView.swift
//  ContactList
//
//  Created by Владимир Есаян on 08.11.2023.
//
import Foundation
import UIKit
import SnapKit

// MARK: - Create UserProfileView
class UserProfileView: UIView {
    // MARK: - Constants
    let photoImageView = UIImageView()
    let nameLabel = UILabel()
    let positionLabel = UILabel()
    let userTagLabel = UILabel()
    let containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(photoImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(userTagLabel)
        addSubview(positionLabel)
        addSubview(containerView)
        backgroundColor = .white
        // вызов функций
        configurePhotoImageView()
        configureNameLabel()
        configurePositionLabel()
        configureUserTagLabel()
        
        // MARK: - setConstraints
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(104)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        userTagLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.leading.equalTo(nameLabel.snp.trailing).offset(4)
            make.trailing.equalToSuperview().offset(-4)
        }
        
        // Установка ограничений для контейнера относительно другого объекта
        containerView.snp.makeConstraints { make in
            make.centerX.equalTo(photoImageView)
            make.top.equalTo(photoImageView.snp.bottom).offset(24)
        }
        positionLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(16)
        }
    }
    
    private func configurePhotoImageView() {
        photoImageView.layer.cornerRadius = 52
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .scaleAspectFill
    }
    
    private func configureNameLabel() {
        nameLabel.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        nameLabel.font = UIFont(name: "Inter-Bold", size: 24)
    }
    
    private func configurePositionLabel() {
        positionLabel.textColor = UIColor(red: 0.333, green: 0.333, blue: 0.361, alpha: 1)
        positionLabel.font = UIFont(name: "Inter-Regular", size: 13)
    }
    
    private func configureUserTagLabel() {
        userTagLabel.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
        userTagLabel.font = UIFont(name: "Inter-Regular", size: 17)
    }
}
