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
class ErrorSearchView: UIView {
    // MARK: - Constants
    private let errorImage = UIImageView()
    private let errorTitleLabel = UILabel()
    private let errorDescriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // FunctionsCall
        setupViews()
        configureErrorImage()
        configureErrorTitleLabel()
        configureDescriptionLabel()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        addSubview(errorImage)
        addSubview(errorTitleLabel)
        addSubview(errorDescriptionLabel)
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
        errorTitleLabel.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        errorTitleLabel.font = UIFont(name: "Inter-SemiBold", size: 17)
        errorTitleLabel.textAlignment = .center
    }
    
    private func configureDescriptionLabel() {
        errorDescriptionLabel.text = "Попробуй скорректировать запрос"
        errorDescriptionLabel.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
        errorDescriptionLabel.font = UIFont(name: "Inter-Regular", size: 16)
        errorDescriptionLabel.textAlignment = .center
    }
    
    // MARK: - Set constraints
    private func setConstraints() {
        errorImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.width.equalTo(56)
        }
        errorTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(errorImage.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        errorDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(errorTitleLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
    }
}
