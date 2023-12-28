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
    private let leftLineView = UIView()
    private let rightLineView = UIView()
    let yearLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        addSubview(yearLabel)
        addSubview(leftLineView)
        addSubview(rightLineView)
        backgroundColor = .white
        // цвет линий
        leftLineView.backgroundColor = UIColor(red: 0.76, green: 0.76, blue: 0.78, alpha: 1)
        rightLineView.backgroundColor = UIColor(red: 0.76, green: 0.76, blue: 0.78, alpha: 1)
        // вызов функций
        configureYearLabel()
        
        // MARK: - Set constraints
        yearLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        leftLineView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(yearLabel.snp.leading).offset(12)
            make.centerY.equalTo(yearLabel.snp.centerY)
            make.width.equalTo(72)
            make.height.equalTo(1)
        }
        rightLineView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.leading.equalTo(yearLabel.snp.trailing).offset(-12)
            make.centerY.equalTo(yearLabel.snp.centerY)
            make.width.equalTo(72)
            make.height.equalTo(1)
        }
    }
    
    // MARK: - Configures
    private func configureYearLabel() {
        yearLabel.text = ""
        yearLabel.font = UIFont(name: "Inter-Medium", size: 15)
        yearLabel.textColor = UIColor(red: 0.765, green: 0.765, blue: 0.776, alpha: 1)
        yearLabel.textAlignment = .center
    }
}
