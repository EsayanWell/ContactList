//
//  SortingViewController.swift
//  ContactList
//
//  Created by Владимир Есаян on 26.10.2023.
//

import Foundation
import UIKit
import SnapKit

class SortingViewController: UIViewController {
    // MARK: - constants
    private let alphabeticallySorting = RadioButtonView()
    private let byBirthdaySorting = RadioButtonView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Сортировка"
        customizeNavigationBar()
        alphabeticallySortingSetup()
        byBirthdaySortingSetup()
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
    
    // MARK: - alphabeticallySorting setup
    func alphabeticallySortingSetup() {
        view.addSubview(alphabeticallySorting)
        alphabeticallySorting.descriptionLabel.text = "По алфавиту"
        alphabeticallySorting.selectButton.isHighlighted = true
        //alphabeticallySorting.selectButton.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
    }
    
    // MARK: - byBirthdaySorting setup
    func byBirthdaySortingSetup() {
        view.addSubview(byBirthdaySorting)
        byBirthdaySorting.descriptionLabel.text = "По дню рождения"
        //byBirthdaySorting.selectButton.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
    }
    
    // переход с сортировки на главный экран
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
    
    //    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
    //        // Получите индекс выбранной радиокнопки
    //        let selectedIndex = sender.selectedSegmentIndex
    //        // Здесь можно выполнить действия в зависимости от выбранной радиокнопки
    //        // Например:
    //        if selectedIndex == 0 {
    //            // Выбрана первая радиокнопка
    //        } else if selectedIndex == 1 {
    //            // Выбрана вторая радиокнопка
    //        } else if selectedIndex == 2 {
    //            // Выбрана третья радиокнопка
    //        }
    //    }
    
    // MARK: - set constraints
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
