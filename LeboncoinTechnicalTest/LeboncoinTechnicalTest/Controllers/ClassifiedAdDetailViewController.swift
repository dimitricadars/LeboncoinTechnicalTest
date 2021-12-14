//
//  ClassifiedAdDetailViewController.swift
//  LeboncoinTechnicalTest
//
//  Created by Dimitri CADARS on 04/12/2021.
//

import Foundation
import UIKit

class ClassifiedAdDetailViewController : UIViewController {
    
    weak var classifiedAdViewModel: ClassifiedAdViewModel?
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
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
        button.addTarget(self, action: #selector(close(sender:)), for: .touchUpInside)
        button.accessibilityIdentifier = "closeDetailButton"
        return button
    }()
    
    private lazy var classifiedAdImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.accessibilityIdentifier = "classifiedAdDetailImage"
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "titleDetailLabel"
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 1
        label.sizeToFit()
        label.textColor = .orange
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "priceDetailLabel"
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 1
        label.sizeToFit()
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "dateDetailLabel"
        return label
    }()
    
    private lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 1
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "descriptionTitleDetailLabel"
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "descriptionDetailLabel"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpInfo()
        setUpViews()
        setUpConstraints()
    }
    
    private func setUpViews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.accessibilityIdentifier = "scrollView"
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(classifiedAdImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(descriptionTitleLabel)
        contentView.addSubview(descriptionLabel)
        view.addSubview(barView)
        barView.addSubview(closeButton)
    }
    
    private func setUpConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(barView.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(barView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(barView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(barView.heightAnchor.constraint(equalToConstant: 60))
        
        constraints.append(closeButton.topAnchor.constraint(equalTo: barView.topAnchor, constant: 15))
        constraints.append(closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15))
        constraints.append(closeButton.heightAnchor.constraint(equalToConstant: 30))
        constraints.append(closeButton.widthAnchor.constraint(equalToConstant: 30))
        
        constraints.append(scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(scrollView.widthAnchor.constraint(equalTo: view.widthAnchor))
        constraints.append(scrollView.topAnchor.constraint(equalTo: view.topAnchor,constant: 60))
        constraints.append(scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        
        constraints.append(contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor))
        constraints.append(contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor))
        constraints.append(contentView.topAnchor.constraint(equalTo: scrollView.topAnchor))
        constraints.append(contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor))
        
        constraints.append(classifiedAdImage.topAnchor.constraint(equalTo: contentView.topAnchor))
        constraints.append(classifiedAdImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))
        constraints.append(classifiedAdImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
        constraints.append(classifiedAdImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width))
        
        constraints.append(titleLabel.topAnchor.constraint(equalTo: classifiedAdImage.bottomAnchor, constant: 20))
        constraints.append(titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10))
        constraints.append(titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10))
        
        constraints.append(priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15))
        constraints.append(priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10))
        constraints.append(priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10))
        
        constraints.append(dateLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10))
        constraints.append(dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10))
        constraints.append(dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10))
        
        constraints.append(descriptionTitleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20))
        constraints.append(descriptionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10))
        constraints.append(descriptionTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10))
        
        constraints.append(descriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 10))
        constraints.append(descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10))
        constraints.append(descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10))
        constraints.append(descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setUpInfo() {
        
        titleLabel.text = classifiedAdViewModel?.title ?? "Titre indisponible"
        priceLabel.text = "\(classifiedAdViewModel?.price ?? 0) €"
        dateLabel.text = classifiedAdViewModel?.creationDate?.toString() ?? "Date inconnue"
        descriptionLabel.text = classifiedAdViewModel?.description ?? "Pas de description."
        classifiedAdImage.loadImageUsingCache(withUrl: classifiedAdViewModel!.imageThumb)
    }
    
    @objc func close(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }
    
}
