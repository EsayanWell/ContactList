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
class RadioButtonView: UIView {
    // MARK: - Constants
    let selectButton = UIButton()
    let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        configureSelectButton()
        configureDescriptionLabel()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(selectButton)
        addSubview(descriptionLabel)
        backgroundColor = .white
    }
    
    // MARK: - Configures
    private func configureSelectButton() {
        // Установка изображения для обычного состояния кнопки
        selectButton.setImage(UIImage(named: "UnSelected"), for: .normal)
        // Установка изображения для состояния кнопки при нажатии
        selectButton.setImage(UIImage(named: "Selected"), for: .highlighted)
    }
    
    private func configureDescriptionLabel() {
        descriptionLabel.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        descriptionLabel.font = UIFont(name: "Inter-Medium", size: 16)
        descriptionLabel.textAlignment = .center
    }
    
    // MARK: - Set constraints
    private func setConstraints() {
        selectButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-18)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(selectButton.snp.trailing).offset(12)
            make.centerY.equalTo(selectButton.snp.centerY)
        }
    }
}
