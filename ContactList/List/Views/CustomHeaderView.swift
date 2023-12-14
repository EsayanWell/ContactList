//
//  CustomHeaderView.swift
//  ContactList
//
//  Created by Владимир Есаян on 14.12.2023.
//

import Foundation
import UIKit
import SnapKit

// MARK: - create customViewController
class CustomHeaderView: UIView {
    // MARK: - Constants
     let yearLabel = UILabel()
    private let leftLineImage = UIImageView()
    private let rightLineImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        configureYearLabel()
        configureLeftLineImage()
        configureRightLineImage()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        addSubview(yearLabel)
        addSubview(leftLineImage)
        addSubview(rightLineImage)
        backgroundColor = .white
    }
    
    // MARK: - Configures
    private func configureYearLabel() {
        yearLabel.text = ""
        yearLabel.font = UIFont(name: "Inter-Medium", size: 15)
        yearLabel.textColor = UIColor(red: 0.765, green: 0.765, blue: 0.776, alpha: 1)
        yearLabel.textAlignment = .center
    }
    
    private func configureLeftLineImage() {
        leftLineImage.clipsToBounds = true
        leftLineImage.contentMode = .scaleAspectFill
        leftLineImage.image = UIImage(named: "Line")
    }
    
    private func configureRightLineImage() {
        rightLineImage.clipsToBounds = true
        rightLineImage.contentMode = .scaleAspectFill
        rightLineImage.image = UIImage(named: "Line")
    }
    
    
    // MARK: - Set constraints
    private func setConstraints() {
        yearLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(160)
        }
        leftLineImage.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(yearLabel.snp.leading).offset(12)
            make.centerY.equalTo(yearLabel.snp.centerY)
            make.width.equalTo(72)
        }
        rightLineImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.leading.equalTo(yearLabel.snp.trailing).offset(-12)
            make.centerY.equalTo(yearLabel.snp.centerY)
            make.width.equalTo(72)
        }
    }
}
