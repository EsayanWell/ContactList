//
//  ViewController.swift
//  ContactList
//
//  Created by Владимир Есаян on 03.10.2023.
//

import UIKit
import SnapKit

class ContactListViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: - Constants
    private let departmentMenuCollectionView = HorizontalMenuCollectionView()
    private let departmentSeacrhBar = CustomSearchBar()
    private let departmentContactList = VerticalContactTableView()
    private let errorReload = ErrorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // скрываю NavigationBar
        navigationController?.setNavigationBarHidden(true, animated: true)
        // вызов функций
        setupViews()
        setConstraits()
        configureErrorReload()
    }
    
    // MARK: - setupViews
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(departmentMenuCollectionView)
        view.addSubview(departmentSeacrhBar)
        view.addSubview(departmentContactList)
        view.addSubview(errorReload)
    }
    
    private func configureErrorReload() {
        // Проверяем наличие данных с сервера
        if ((departmentContactList.indexPathForSelectedRow?.isEmpty) != nil) {
            // Если данных нет, создаем и добавляем кастомную view
            errorReload.isHidden = false
            departmentSeacrhBar.isHidden = true
            departmentMenuCollectionView.isHidden = true
            departmentContactList.isHidden = true
        } else {
            // Если данные есть, удаляем кастомную view (если она была добавлена ранее)
            errorReload.isHidden = true
            departmentSeacrhBar.isHidden = false
            departmentMenuCollectionView.isHidden = false
            departmentContactList.isHidden = false
        }
    }

    // MARK: - setConstraits
    private func setConstraits() {
        departmentSeacrhBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        departmentMenuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(departmentSeacrhBar.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview()
            make.height.equalTo(36)
        }
        departmentContactList.snp.makeConstraints { make in
            make.top.equalTo(departmentMenuCollectionView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
        errorReload.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(303)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
}
