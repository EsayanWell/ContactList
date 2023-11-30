//
//  CustomErrorView.swift
//  ContactList
//
//  Created by Владимир Есаян on 08.11.2023.
//

import Foundation
import UIKit
import SnapKit

// MARK: - create customViewController
class ErrorSeacrhView: UIView {
    // MARK: - Constants
    private let errorImage = UIImageView()
    private let errorTitleLabel = UILabel()
    private let errorDecriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        configureErrorImage()
        configureErrorTitleLabel()
        configureDescriptionLabel()
        setConstraits()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(errorImage)
        addSubview(errorTitleLabel)
        addSubview(errorDecriptionLabel)
        backgroundColor = .white
    }
    
    // MARK: - Configures
    private func configureErrorImage() {
        errorImage.clipsToBounds = true
        errorImage.contentMode = .scaleAspectFill
        errorImage.image = UIImage(named: "loop")
    }
    
    private func configureErrorTitleLabel() {
        errorTitleLabel.text = "Мы никого не нашли"
        // цвет текста
        errorTitleLabel.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        // шрифт
        errorTitleLabel.font = UIFont(name: "Inter-SemiBold", size: 17)
        errorTitleLabel.textAlignment = .center
    }
    
    private func configureDescriptionLabel() {
        errorDecriptionLabel.text = "Попробуй скорректировать запрос"
        // цвет текста
        errorDecriptionLabel.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
        // шрифт
        errorDecriptionLabel.font = UIFont(name: "Inter-Regular", size: 16)
        errorDecriptionLabel.textAlignment = .center
    }
        
    // MARK: - setConstraits
    private func setConstraits() {
        errorImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.width.equalTo(56)
        }
        errorTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(errorImage.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        errorDecriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(errorTitleLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
    }
}
