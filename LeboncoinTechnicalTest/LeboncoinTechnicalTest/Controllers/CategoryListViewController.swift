//
//  CategoryListViewController.swift
//  LeboncoinTechnicalTest
//
//  Created by Dimitri CADARS on 04/12/2021.
//

import Foundation
import UIKit

protocol CategoryDelegate {
    func categoryDidSelected(categoryId: Int)
}

class CategoryListViewController : UIViewController {
    
    var categoriesVM : CategoriesViewModel!
    var delegate : CategoryDelegate?
    
    private lazy var barView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "cancel-30"), for: .normal)
        button.addTarget(self, action: #selector(onCloseTap(sender:)), for: .touchUpInside)
        button.accessibilityIdentifier = "filterCloseButton"
        return button
    }()
    
    private lazy var categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Choisir une catégorie"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 1
        label.sizeToFit()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "categoryTitle"
        return label
    }()
    
    private lazy var categoriesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "categoryTableViewCell")
        tableView.accessibilityIdentifier = "categoriesTableView"
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    private func setUpViews() {
        view.addSubview(barView)
        barView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        barView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        barView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        barView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        barView.addSubview(closeButton)
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        barView.addSubview(categoryTitleLabel)
        categoryTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18).isActive = true
        categoryTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        categoryTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        view.addSubview(categoriesTableView)
        categoriesTableView.topAnchor.constraint(equalTo: barView.bottomAnchor).isActive = true
        categoriesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        categoriesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        categoriesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        categoriesTableView.dataSource = self
        categoriesTableView.delegate = self
    }
    
    @objc func onCloseTap(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }
}

extension CategoryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesVM.categoryViewModels.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryTableViewCell", for: indexPath)
        cell.textLabel?.textAlignment = .center
        if (indexPath.row == 0) {
            cell.textLabel?.text = "Toutes les catégories"
        } else {
            cell.textLabel?.text = categoriesVM.categoryViewModels[indexPath.row-1].name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var selectedCategoryID: Int = 0
        
        if (indexPath.row == 0) {
            selectedCategoryID = 0
        } else {
            selectedCategoryID = categoriesVM.categoryViewModels[indexPath.row-1].id
        }
        
        self.delegate?.categoryDidSelected(categoryId: selectedCategoryID)
        dismiss(animated: true, completion: nil)
    }
}
