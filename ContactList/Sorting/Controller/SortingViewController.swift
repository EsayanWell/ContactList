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
    // создание радиокнопки
    private let alphabeticallySorting = RadioButtonView()
    private let byBirthdaySorting = RadioButtonView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Сортировка"
        // меняем цвет текста заголовка
        alphabeticallySortingSetup()
        byBirthdaySortingSetup()
        setConstraints()
        view.addSubview(alphabeticallySorting)
        view.addSubview(byBirthdaySorting)
    }
    
    // segmentControl setup
    func alphabeticallySortingSetup() {
        alphabeticallySorting.descriptionLabel.text = "По алфавиту"
        //alphabeticallySorting.selectButton.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
    }
    
    // segmentControl setup
    func byBirthdaySortingSetup() {
        byBirthdaySorting.descriptionLabel.text = "По дню рождения"
        //byBirthdaySorting.selectButton.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
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
    
    func setConstraints() {
        alphabeticallySorting.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().offset(24)
            make.height.equalTo(60)
        }
        byBirthdaySorting.snp.makeConstraints { make in
            make.top.equalTo(alphabeticallySorting.snp.bottom)
            make.leading.trailing.equalToSuperview().offset(24)
        }
    }
}
