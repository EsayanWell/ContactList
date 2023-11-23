//
//  DepartmentCell.swift
//  ContactList
//
//  Created by Владимир Есаян on 09.10.2023.
//

import UIKit
import SnapKit

class DepartmentCell: UICollectionViewCell {
    let departmentName = UILabel()
    let selectedCell = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // MARK: - sets
        setupViews()
        setupCell()
        configureDepartmentLabel()
        setConstraits()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configures
    private func setupViews() {
        addSubview(departmentName)
        addSubview(selectedCell)
    }
    
    func setupCell() {
        // цвет полоски
        selectedCell.backgroundColor = UIColor(red: 0.396, green: 0.204, blue: 1, alpha: 1)
        selectedCell.isHidden = true
    }
    
    // функция выполняет задачу обновления интерфейсных элементов на экране информацией из объекта Expense, переданного в качестве параметра
    func set(department: Departments) {
        departmentName.text = department.title
    }
    
    func configureDepartmentLabel() {
        // цвет и шрифт из Figma
        departmentName.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
        departmentName.font = UIFont(name: "Inter-Medium", size: 15)
    }
    
    // MARK: - constraits
    func setConstraits() {
        departmentName.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(selectedCell.snp.top)
        }
        
        selectedCell.snp.makeConstraints { make in
            make.top.equalTo(departmentName.snp.bottom)
            make.leading.equalTo(departmentName).offset(-12)
            make.trailing.equalTo(departmentName).offset(12)
            make.bottom.equalToSuperview()
            make.height.equalTo(2)
        }
    }
}
