//
//  DepartmentCollectionView.swift
//  ContactList
//
//  Created by Владимир Есаян on 11.10.2023.
//

import Foundation
import UIKit

class DepartmentCollectionView: UICollectionView {
    
    // MARK: - Constants
    private let identifire = "DepartmentCell"
    private var departments: [Department] = []
    private let departmentLayout = UICollectionViewFlowLayout()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: departmentLayout)
        configureCollectionView()
        setCollectionViewDelegates()
        departments = fetchData()

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure TableView
    private func configureCollectionView() {
        departmentLayout.scrollDirection = .horizontal
        departmentLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.backgroundColor = .white
        self.register(DepartmentCell.self, forCellWithReuseIdentifier: identifire)
        self.showsHorizontalScrollIndicator = false
    }
    
    // функция с установкой подписки на delegates
    func setCollectionViewDelegates() {
        self.delegate = self
        self.dataSource = self
    }
}

// MARK: - Extensions for DepartmentCollectionView
extension DepartmentCollectionView : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return departments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifire, for: indexPath) as! DepartmentCell
        let department = departments[indexPath.row]
        cell.set(department: department)
        return cell
    }
}

extension DepartmentCollectionView{
    
    // функция не принимает аргументов и возвращает массив типа Expense (структура в модели)
    func fetchData() -> [Department] {
        let department1  = Department(title: "Все")
        let department2  = Department(title: "Android")
        let department3  = Department(title: "iOS")
        let department4  = Department(title: "Дизайн")
        let department5  = Department(title: "Менеджмент")
        let department6  = Department(title: "QA")
        let department7  = Department(title: "Бэк-офис")
        let department8  = Department(title: "Frontend")
        let department9  = Department(title: "HR")
        let department10 = Department(title: "PR")
        let department11 = Department(title: "Backend")
        let department12 = Department(title: "Техподдержка")
        let department13 = Department(title: "Аналитика")
        
        return [department1, department2, department3, department4, department5, department6, department7, department8, department9, department10, department11, department12, department13]
    }
}
