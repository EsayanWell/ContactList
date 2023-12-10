//
//  SortingViewController.swift
//  ContactList
//
//  Created by Владимир Есаян on 26.10.2023.
//

import Foundation
import UIKit
import SnapKit

// enum сортировки
enum SortingType {
    case alphabetically
    case byBirthday
}

//протокол для передачи данных между SortingViewController и ContactListViewController
protocol DataSortingDelegate: AnyObject{
    func applySorting(_ sortingType: SortingType)
}

class SortingViewController: UIViewController {
    // MARK: - Constants
    private let alphabeticallySorting = RadioButtonView()
    private let byBirthdaySorting = RadioButtonView()
    // добавляем свойство делегата типа DataSortingDelegate в SortingViewController
    weak var sortingDelegate: DataSortingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Сортировка"
        customizeNavigationBar()
        applySorting(.alphabetically)
        applySorting(.byBirthday)
        backButtonSetup()
        setConstraints()
    }
    
    // MARK: - Customize NavigationBar
    func customizeNavigationBar() {
        // Создаем объект шрифта
        let customFont = UIFont(name: "Inter-SemiBold", size: 20) ?? UIFont.systemFont(ofSize: 20.0, weight: .medium)
        // Создаем атрибуты текста с заданным шрифтом
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: customFont,
            .foregroundColor: UIColor.black
        ]
        // Устанавливаем атрибуты текста для заголовка навигационной панели
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    // MARK: - Sorting setup
    func applySorting(_ sortingType: SortingType) {
        // вызов делегата
        sortingDelegate?.applySorting(sortingType)
        let sortingView: RadioButtonView
        let description: String
        
        switch sortingType {
        case .alphabetically:
            sortingView = alphabeticallySorting
            description = "По алфавиту"
            sortingView.selectButton.isHighlighted = true
        case .byBirthday:
            sortingView = byBirthdaySorting
            description = "По дню рождения"
        }
        view.addSubview(sortingView)
        sortingView.descriptionLabel.text = description
        sortingView.selectButton.addTarget(self, action: #selector(sortingButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - sorting button tapped
    @objc func sortingButtonTapped() {
        print("sortingButton tapped")
    }
    
    // MARK: - backButtonSetup
    func backButtonSetup() {
        let backButton = UIBarButtonItem(image: UIImage(named: "Arrow"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(dismissViewController))
        backButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton
    }
    
    // обработчик нажатия на cтрелку
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
    
    // MARK: - Set constraints
    func setConstraints() {
        alphabeticallySorting.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(68)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(60)
        }
        byBirthdaySorting.snp.makeConstraints { make in
            make.top.equalTo(alphabeticallySorting.snp.bottom)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(60)
        }
    }
}
