//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Nikita Byzov on 07.08.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    //MARK: - Задание элементов, которые будем показывать
    
    private lazy var infoLabelStart: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 21)
        label.numberOfLines = 0
        label.text = Constants.infoTextStart
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var infoLabelEnd: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 0
        label.text = Constants.infoTextEnd
        label.sizeToFit()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupView()
    }
    
    //MARK: - Создание и настройка
    
    private func setupNavigation(){
        navigationItem.title = Constants.infoTitleView
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupView(){
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(infoLabelStart)
        contentView.addSubview(infoLabelEnd)
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -10),
            
            infoLabelStart.topAnchor.constraint(equalTo: contentView.topAnchor),
            infoLabelStart.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            infoLabelStart.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            infoLabelEnd.topAnchor.constraint(equalTo: infoLabelStart.bottomAnchor, constant: 8),
            infoLabelEnd.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            infoLabelEnd.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            infoLabelEnd.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
    }
    
}
