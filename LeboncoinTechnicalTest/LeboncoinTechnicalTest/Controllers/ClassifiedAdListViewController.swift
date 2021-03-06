//
//  ClassifiedAdListViewController.swift
//  LeboncoinTechnicalTest
//
//  Created by Dimitri CADARS on 04/12/2021.
//

import Foundation
import UIKit

class ClassifiedAdListViewController : UIViewController, CategoryDelegate {
    
    private var classifiedAdsVM = ClassifiedAdsViewModel()
    private var categoriesVM = CategoriesViewModel()
    private var filteredClassifiedAdsVM : [ClassifiedAdViewModel]!
    
    var selectedCategoryID: Int = 0
    
    private lazy var classifiedAdsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ClassifiedAdTableViewCell.self, forCellReuseIdentifier: "classifiedAdTableViewCell")
        tableView.separatorStyle = .none
        tableView.accessibilityIdentifier = "classifiedAdsTableView"
        return tableView
    }()
    
    private lazy var filterBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "filter-30"), style: .plain, target: self, action: #selector(onFilterButtonClicked))
        barButtonItem.accessibilityIdentifier = "filterBarButton"
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        setUpTableView()
        setUpNavigationController()
        getCategoriesVM()
        getClassifiedAdsVM()
    }
    
    private func setUpTableView() {
        view.addSubview(classifiedAdsTableView)
        classifiedAdsTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        classifiedAdsTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        classifiedAdsTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        classifiedAdsTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        
        classifiedAdsTableView.dataSource = self
        classifiedAdsTableView.delegate = self
    }
    
    private func setUpNavigationController() {
        navigationItem.title = "leboncoin"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem  = self.filterBarButtonItem
    }
    
    private func getClassifiedAdsVM() {
        let loader = self.loader()
        classifiedAdsVM.getClassifiedAds { [weak self] result in
            switch result {
            case .success(let arrayClassifiedAd):
                if let sortClassifiedAdViewModels = self?.classifiedAdsVM.sortClassifiedAdsByDateAndUrgency(arrayClassifiedAd: arrayClassifiedAd) {
                    self?.classifiedAdsVM.classifiedAdViewModels = sortClassifiedAdViewModels
                    self?.classifiedAdsTableView.reloadData()
                    self?.stopLoader(loader: loader)
                }
            case .failure:
                self?.stopLoader(loader: loader)
                self?.displayAlert(message: "D??sol??, quelque chose s'est mal pass?? dans la r??cup??ration des annonces. R??essayez plus tard",title: "Error")
            }
        }
    }
    
    private func getCategoriesVM() {
        let loader = self.loader()
        categoriesVM.getCategories() { [weak self] result in
            switch result {
            case .success(let arrayCategory):
                self?.categoriesVM.categoryViewModels = arrayCategory
                self?.stopLoader(loader: loader)
            case .failure:
                self?.stopLoader(loader: loader)
                self?.displayAlert(message: "D??sol??, quelque chose s'est mal pass??. R??essayez plus tard",title: "Error")
            }
        }
    }
    
    func categoryDidSelected(categoryId: Int) {
        let loader = self.loader()
        self.selectedCategoryID = categoryId
        if (self.selectedCategoryID != 0) {
            filteredClassifiedAdsVM = classifiedAdsVM.filterClassifiedAdsByCategoryID(catID: selectedCategoryID)
        } else {
            filteredClassifiedAdsVM = classifiedAdsVM.classifiedAdViewModels
        }
        
        self.classifiedAdsTableView.reloadData()
        self.stopLoader(loader: loader)
    }
    
    @objc func onFilterButtonClicked(_ sender: Any){
        let categoryListVC = CategoryListViewController()
        categoryListVC.categoriesVM = categoriesVM
        categoryListVC.delegate = self
        present(categoryListVC, animated: true, completion: nil)
    }
}


extension ClassifiedAdListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedCategoryID == 0 {
            return self.classifiedAdsVM.numberOfRows(section)
        } else {
            return self.filteredClassifiedAdsVM.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classifiedAdTableViewCell", for: indexPath) as! ClassifiedAdTableViewCell
        var classifiedAdVM = self.classifiedAdsVM.classifiedAdViewModels[indexPath.row]
        if selectedCategoryID != 0 {
            classifiedAdVM = (self.filteredClassifiedAdsVM?[indexPath.row])!
        }
        cell.configure(classifiedAdVM, categories: self.categoriesVM)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ClassifiedAdDetailViewController()
        if selectedCategoryID != 0 {
            vc.classifiedAdViewModel = filteredClassifiedAdsVM[indexPath.row]
        } else {
            vc.classifiedAdViewModel = classifiedAdsVM.classifiedAdViewModels[indexPath.row]
        }
        present(vc, animated: true, completion: nil)
    }
}
