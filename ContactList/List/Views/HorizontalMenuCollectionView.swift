//
//  DepartmentCollectionView.swift
//  ContactList
//
//  Created by Владимир Есаян on 11.10.2023.
//

import Foundation
import UIKit

class HorizontalMenuCollectionView: UICollectionView {
    
    // MARK: - Constants
    private let identifier = "DepartmentCell"
    private var departments: [Department] = []
    private let departmentLayout = UICollectionViewFlowLayout()
    // Индекс выбранной ячейки
    private var selectedIndexPath: IndexPath?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: departmentLayout)
        configureCollectionView()
        setCollectionViewDelegates()
        departments = fetchData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure UICollectionView
    private func configureCollectionView() {
        // возможность горизонтального перемещения таблицы
        departmentLayout.scrollDirection = .horizontal
        // изменение размера ячейки в зависимости от введенного текста
        departmentLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        // расстояние между ячейками горизонтальной таблицы (department)
        departmentLayout.minimumInteritemSpacing = 12
        self.backgroundColor = .white
        self.register(DepartmentCell.self, forCellWithReuseIdentifier: identifier)
        self.showsHorizontalScrollIndicator = false
    }
    
    // функция с установкой подписки на delegates
    func setCollectionViewDelegates() {
        self.delegate = self
        self.dataSource = self
    }
}

// MARK: - Extensions for HorizontalMenuCollectionView
extension HorizontalMenuCollectionView : UICollectionViewDelegate, UICollectionViewDataSource {
    // кол-во элементов в секции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return departments.count
    }
    
    // MARK: - Cell setup
    // настройка ячеек таблицы
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? DepartmentCell else {
            return UICollectionViewCell()
        }
        let department = departments[indexPath.row]
        cell.set(department: department)
        
        if selectedIndexPath == indexPath {
            // Если текущая ячейка выбрана, установить желаемый цвет шрифта
            cell.departmentName.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
            cell.selectedCell.isHidden = false
        } else {
            // Если ячейка не выбрана, вернуть её в исходное состояние
            // если не спрятать cell, будут выделяться несколько ячеек
            cell.departmentName.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
            cell.selectedCell.isHidden = true
        }
        return cell
    }
    
    // Настройка выбранной ячейки
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Снять выделение с предыдущей выбранной ячейки, если она существует
        if let previousSelectedIndexPath = selectedIndexPath,
           let previousCell = collectionView.cellForItem(at: previousSelectedIndexPath) as? DepartmentCell
        {
            previousCell.departmentName.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
            previousCell.selectedCell.isHidden = true
        }
        // Установить выбранной ячейке индекс и обновите её
        selectedIndexPath = indexPath
        collectionView.reloadItems(at: [indexPath])
        // метод для выравнивания выбранной ячейки
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension HorizontalMenuCollectionView{
    
    // функция не принимает аргументов и возвращает массив типа Department (структура в модели)
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
