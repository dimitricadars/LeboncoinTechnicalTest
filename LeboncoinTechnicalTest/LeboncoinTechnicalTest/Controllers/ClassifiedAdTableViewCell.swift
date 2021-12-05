//
//  ClassifiedAdTableViewCell.swift
//  LeboncoinTechnicalTest
//
//  Created by Dimitri CADARS on 04/12/2021.
//

import Foundation
import UIKit

class ClassifiedAdTableViewCell: UITableViewCell {
    
    static let identifier = "classifiedAdTableViewCell"
    
    private lazy var classifiedAdImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.accessibilityIdentifier = "classifiedAdImage"
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.minimumScaleFactor = 0.5
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.accessibilityIdentifier = "titleLabel"
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.minimumScaleFactor = 0.5
        label.font = label.font.withSize(14)
        label.accessibilityIdentifier = "categoryLabel"
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .orange
        label.minimumScaleFactor = 0.5
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.accessibilityIdentifier = "priceLabel"
        return label
    }()
    
    private lazy var urgentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.minimumScaleFactor = 0.5
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.font = label.font.withSize(10)
        label.backgroundColor = .orange
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.accessibilityIdentifier = "urgentLabel"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        contentView.addSubview(classifiedAdImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(urgentLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        
        var constraints = [NSLayoutConstraint]()
        
        // classifiedAdImage contraints
        constraints.append(classifiedAdImage.widthAnchor.constraint(equalToConstant: 150))
        constraints.append(classifiedAdImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10))
        constraints.append(classifiedAdImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10))
        constraints.append(classifiedAdImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10))
        
        // titleLabel contraints
        constraints.append(titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20))
        constraints.append(titleLabel.leadingAnchor.constraint(equalTo: classifiedAdImage.trailingAnchor, constant: 10))
        constraints.append(titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10))
        
        // categoryLabel contraints
        constraints.append(categoryLabel.widthAnchor.constraint(equalToConstant: 200))
        constraints.append(categoryLabel.leadingAnchor.constraint(equalTo: classifiedAdImage.trailingAnchor, constant: 10))
        constraints.append(categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20))
    
        // priceLabel contraints
        constraints.append(priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10))
        constraints.append(priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20))
        
        // urgentLabel contraints
        constraints.append(urgentLabel.topAnchor.constraint(equalTo: classifiedAdImage.topAnchor, constant: 10))
        constraints.append(urgentLabel.leadingAnchor.constraint(equalTo: classifiedAdImage.leadingAnchor, constant: 10))

        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(_ vm: ClassifiedAdViewModel, categories : CategoriesViewModel) {
        self.titleLabel.text = vm.title
        categoryLabel.text = categories.getCategoryName(by: vm.categoryID)
        priceLabel.text = "\(vm.price) €"
        urgentLabel.text = vm.isUrgent ? "  URGENT  " : ""
        urgentLabel.isHidden = vm.isUrgent ? false : true
        
        if let url = URL(string: vm.imageSmall) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
        
                DispatchQueue.main.async {
                    self.classifiedAdImage.image = UIImage(data: data) ?? UIImage(named: "placeholder")
                }
            }
            task.resume()
        }
    }
}

