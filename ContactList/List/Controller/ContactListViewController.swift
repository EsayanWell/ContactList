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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // скрываю NavigationBar
        navigationController?.setNavigationBarHidden(true, animated: true)
        // вызов функций
        setupViews()
        setConstraits()
    }
    
    // MARK: - setupViews
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(departmentMenuCollectionView)
        view.addSubview(departmentSeacrhBar)
        view.addSubview(departmentContactList)
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        let rootVC = SortingViewController()
        let sortVC = UINavigationController(rootViewController: rootVC)
        //метод, который отображает второй экран полностью
        sortVC.modalPresentationStyle = .fullScreen
        present(sortVC, animated: true)
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
    }
}
