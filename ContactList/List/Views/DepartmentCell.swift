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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // add to view
        addSubview(departmentName)
        
        // MARK: - sets
        configureDepartmentLabel()
        setConstraits()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // функция выполняет задачу обновления интерфейсных элементов на экране информацией из объекта Expense, переданного в качестве параметра
    func set(department: Department) {
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
            // прибивает все 4 стороны
            make.edges.equalToSuperview()
        }
    }
    func selectItem() {
        // Получите выбранную ячейку
        // Установите цвет текста UILabel в зависимости от выбранной ячейки
        if self.isSelected {
            departmentName.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        } else {
            departmentName.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
        }
    }
}
