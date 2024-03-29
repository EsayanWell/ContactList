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

// протокол для передачи данных между SortingViewController и ContactListViewController
protocol DataSortingDelegate: AnyObject{
    func applySorting(_ sortingType: SortingType)
}

class SortingViewController: UIViewController {
    // MARK: - Constants
    private let alphabeticallySortingView = RadioButtonView()
    private let byBirthdaySortingView = RadioButtonView()
    private let initialSortingType: SortingType
    // добавляем свойство делегата типа DataSortingDelegate в SortingViewController
    weak var sortingDelegate: DataSortingDelegate?
    
    init(initialSortingType: SortingType) {
        self.initialSortingType = initialSortingType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        backButtonSetup()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        title = "Сортировка"
        // вызов функций
        customizeNavigationBar()
        setupSorting(.alphabetically)
        setupSorting(.byBirthday)
        
        // MARK: - Set constraints
        alphabeticallySortingView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(68)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(60)
        }
        byBirthdaySortingView.snp.makeConstraints { make in
            make.top.equalTo(alphabeticallySortingView.snp.bottom)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(60)
        }
    }
    
    // MARK: - Customize NavigationBar
    private func customizeNavigationBar() {
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
    private func setupSorting(_ sortingType: SortingType) {
        let sortingView: RadioButtonView
        let description: String
        switch sortingType {
        case .alphabetically:
            sortingView = alphabeticallySortingView
            description = "По алфавиту"
            // сохранение выбора сортировки при повторном переходе на экран
            sortingView.selectButton.isSelected = initialSortingType == sortingType
            sortingView.selectButton.addTarget(self, action: #selector(alphabeticallyButtonTapped), for: .touchUpInside)
            // добавление нажатие на label
            let tapGestureAlph = UITapGestureRecognizer(target: self,action: #selector(alphabeticallyButtonTapped))
            sortingView.descriptionLabel.addGestureRecognizer(tapGestureAlph)
        case .byBirthday:
            sortingView = byBirthdaySortingView
            description = "По дню рождения"
            // сохранение выбора сортировки при повторном переходе на экран
            sortingView.selectButton.isSelected = initialSortingType == sortingType
            sortingView.selectButton.addTarget(self, action: #selector(byBirthdayButtonTapped), for: .touchUpInside)
            let tapGestureBirth = UITapGestureRecognizer(target: self,action: #selector(byBirthdayButtonTapped))
            sortingView.descriptionLabel.addGestureRecognizer(tapGestureBirth)
        }
        view.addSubview(sortingView)
        sortingView.descriptionLabel.text = description
    }
    
    // MARK: - sorting button tapped
    @objc func alphabeticallyButtonTapped(_ sender: UIButton) {
        sortingDelegate?.applySorting(.alphabetically)
        alphabeticallySortingView.selectButton.isSelected = true
        byBirthdaySortingView.selectButton.isSelected = false
    }
    
    @objc func byBirthdayButtonTapped(_ sender: UIButton) {
        sortingDelegate?.applySorting(.byBirthday)
        alphabeticallySortingView.selectButton.isSelected = false
        byBirthdaySortingView.selectButton.isSelected = true
    }
    
    // MARK: - backButtonSetup
    private func backButtonSetup() {
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
}
