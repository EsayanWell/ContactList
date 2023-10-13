//
//  DepartmentCollectionView.swift
//  ContactList
//
//  Created by Владимир Есаян on 11.10.2023.
//

import Foundation
import UIKit

class DepartmentMenuCollectionView: UICollectionView {
    
    // MARK: - Constants
    private let identifire = "DepartmentCell"
    private var departments: [Department] = []
    private let departmentLayout = UICollectionViewFlowLayout()
    var selectedIndexPath: IndexPath? // Индекс выбранной ячейки
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: departmentLayout)
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
        // изменение размера ячейки в зависимости от введенного текста
        departmentLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        departmentLayout.minimumLineSpacing = 24
        //self.isPagingEnabled = true
        self.backgroundColor = .white
        self.register(DepartmentCell.self, forCellWithReuseIdentifier: identifire)
        self.showsHorizontalScrollIndicator = false
        //self.isScrollEnabled = true
        //self.isPagingEnabled = true
    }
    
    // функция с установкой подписки на delegates
    func setCollectionViewDelegates() {
        self.delegate = self
        self.dataSource = self
    }
}

// MARK: - Extensions for DepartmentCollectionView
extension DepartmentMenuCollectionView : UICollectionViewDelegate, UICollectionViewDataSource {
    
    // кол-во элементов в секции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return departments.count
    }
    
    // MARK: - Cell setup
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifire, for: indexPath) as! DepartmentCell
        let department = departments[indexPath.row]
        cell.set(department: department)
        
        if selectedIndexPath == indexPath {
            // Если текущая ячейка выбрана, установите желаемый цвет шрифта
            cell.departmentName.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
            cell.selectedCell.isHidden = false
        } else {
            // Если ячейка не выбрана, верните её в исходное состояние
            // если не спрятать cell, будут выделяться несколько ячеек
            cell.departmentName.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
            cell.selectedCell.isHidden = true
        }
        return cell
        
    }
    
    // Настройка выбранной ячейки
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Снимите выделение с предыдущей выбранной ячейки
        if let previousSelectedIndexPath = selectedIndexPath {
            let previousCell = collectionView.cellForItem(at: previousSelectedIndexPath) as! DepartmentCell
            previousCell.departmentName.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1) // Исходный цвет шрифта
            previousCell.selectedCell.isHidden = true
        }
        // Установите выбранной ячейке индекс и обновите её
        selectedIndexPath = indexPath
        collectionView.reloadItems(at: [indexPath])
    }
}

extension DepartmentMenuCollectionView{
    
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
