//
//  DepartmentCell.swift
//  ContactList
//
//  Created by Владимир Есаян on 09.10.2023.
//

import UIKit
import SnapKit

class DepartmentCell: UICollectionViewCell {
    let departmentNameLabel = UILabel()
    let selectedCellView = UIView()
    var collectionViewIdentifier: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configures
    private func setupViews() {
        addSubview(departmentNameLabel)
        addSubview(selectedCellView)
        // вызов функций
        setupCellView()
        configureDepartmentLabel()
        
        // MARK: - setConstraints
        departmentNameLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        selectedCellView.snp.makeConstraints { make in
            make.top.equalTo(departmentNameLabel.snp.bottom)
            make.leading.equalTo(departmentNameLabel).offset(-12)
            make.trailing.equalTo(departmentNameLabel).offset(12)
            make.bottom.equalToSuperview()
            make.height.equalTo(2)
        }
    }
    
    private func setupCellView() {
        // цвет полоски
        selectedCellView.backgroundColor = UIColor(red: 0.396, green: 0.204, blue: 1, alpha: 1)
        selectedCellView.isHidden = true
    }
    
    // функция выполняет задачу обновления интерфейсных элементов на экране информацией из объекта Expense, переданного в качестве параметра
    func set(department: Departments) {
        departmentNameLabel.text = department.title
    }
    
    private func configureDepartmentLabel() {
        departmentNameLabel.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
        departmentNameLabel.font = UIFont(name: "Inter-Medium", size: 15)
    }
}
