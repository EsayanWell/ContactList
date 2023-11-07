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
    private let sortSegmentControl = UISegmentedControl(items: ["По алфавиту", "По дню рождения"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControllSetup()
        setConstraits()
    }
    
    // segmentControl setup
    func segmentControllSetup() {
        sortSegmentControl.selectedSegmentIndex = 0
        view.addSubview(sortSegmentControl)
        sortSegmentControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        // Получите индекс выбранной радиокнопки
        let selectedIndex = sender.selectedSegmentIndex
        // Здесь можно выполнить действия в зависимости от выбранной радиокнопки
        // Например:
        if selectedIndex == 0 {
            // Выбрана первая радиокнопка
        } else if selectedIndex == 1 {
            // Выбрана вторая радиокнопка
        } else if selectedIndex == 2 {
            // Выбрана третья радиокнопка
        }
    }
    
    func setConstraits() {
        sortSegmentControl.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
