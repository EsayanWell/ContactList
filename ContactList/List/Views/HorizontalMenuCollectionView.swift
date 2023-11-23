//
//  DepartmentCollectionView.swift
//  ContactList
//
//  Created by Владимир Есаян on 11.10.2023.
//

import Foundation
import UIKit

// протокол, который будет оповещать ваш UITableView о необходимости обновления данных
protocol FilterDelegate: AnyObject {
    func didSelectFilter(at indexPath: IndexPath, selectedData: Departments)
}

class HorizontalMenuCollectionView: UICollectionView {
    
    // MARK: - Constants
    private let identifier = "DepartmentCell"
    private var departments: [Departments] = []
    private let departmentLayout = UICollectionViewFlowLayout()
    // Индекс выбранной ячейки
    private var selectedIndexPath: IndexPath?
    // добавляем делегат в наш класс
    internal weak var filterDelegate: FilterDelegate?
    
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
        self.backgroundColor = .white
        self.register(DepartmentCell.self, forCellWithReuseIdentifier: identifier)
        self.showsHorizontalScrollIndicator = false
        // Выбираем индекс ячейки по умолчанию (например, первая ячейка)
        // let defaultIndexPath = IndexPath(item: 0, section: 0)
        // Выбираем ячейку по умолчанию
         self.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .centeredHorizontally)
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
            return DepartmentCell()
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
        // вызов делегата при выборе ячейки
        if let selectedIndexPath = selectedIndexPath {
            let selectedFilter = departments[selectedIndexPath.item]
            filterDelegate?.didSelectFilter(at: selectedIndexPath, selectedData: selectedFilter)
        } else {
            print("Delegate not called")
        }
    }
}

extension HorizontalMenuCollectionView{
    
    // функция не принимает аргументов и возвращает массив типа Departments (структура в модели)
    func fetchData() -> [Departments] {
        let allDepartments  = Departments.all
        let androidDep  = Departments.android
        let iosDep  = Departments.iOS
        let designDep  = Departments.design
        let managementDep  = Departments.management
        let qaDep  = Departments.qa
        let backOfficeDep  = Departments.backOffice
        let frontendDep  = Departments.frontend
        let hrDep  = Departments.hr
        let prDep = Departments.pr
        let backendDep = Departments.backend
        let supportDep = Departments.support
        let analyticsDep = Departments.analytics
        
        return [allDepartments, androidDep, iosDep, designDep, managementDep, qaDep, backOfficeDep, frontendDep, hrDep, prDep, backendDep, supportDep, analyticsDep]
    }
}
