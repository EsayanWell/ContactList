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
class ErrorLoadView: UIView {
    // MARK: - Constants
    private let errorImageView = UIImageView()
    private let errorTitleLabel = UILabel()
    private let errorDescriptionLabel = UILabel()
    let tryRequestButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        addSubview(errorImageView)
        addSubview(errorTitleLabel)
        addSubview(errorDescriptionLabel)
        addSubview(tryRequestButton)
        backgroundColor = .white
        // вызов функций
        configureErrorImageView()
        configureErrorTitleLabel()
        configureDescriptionLabel()
        configureRequestButton()
        
        // MARK: - Set constraints
        errorImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.width.equalTo(56)
        }
        errorTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(errorImageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        errorDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(errorTitleLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        tryRequestButton.snp.makeConstraints { make in
            make.top.equalTo(errorDescriptionLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(343)
        }
    }
    
    // MARK: - Configures
    private func configureErrorImageView() {
        errorImageView.clipsToBounds = true
        errorImageView.contentMode = .scaleAspectFill
        errorImageView.image = UIImage(named: "flying-saucer")
    }
    
    private func configureErrorTitleLabel() {
        errorTitleLabel.text = "Какой-то сверхразум все сломал"
        errorTitleLabel.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        errorTitleLabel.font = UIFont(name: "Inter-SemiBold", size: 17)
        errorTitleLabel.textAlignment = .center
    }
    
    private func configureDescriptionLabel() {
        errorDescriptionLabel.text = "Постараемся быстро починить"
        errorDescriptionLabel.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
        errorDescriptionLabel.font = UIFont(name: "Inter-Regular", size: 16)
        errorDescriptionLabel.textAlignment = .center
    }
    
    private func configureRequestButton() {
        tryRequestButton.setTitle("Попробовать снова", for: .normal)
        tryRequestButton.backgroundColor = .white
        tryRequestButton.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 16)
        tryRequestButton.setTitleColor(UIColor.systemGray4, for: .highlighted)
        tryRequestButton.setTitleColor(UIColor(red: 0.396, green: 0.204, blue: 1, alpha: 1), for: .normal)
    }
}
