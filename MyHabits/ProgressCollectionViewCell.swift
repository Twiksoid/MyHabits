//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Nikita Byzov on 10.08.2022.
//
// сама ячейка (прогресс-бар), как отображается

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.textBarTitile
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.text = "0%"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var progressBar: UIProgressView = {
        let progress = UIProgressView()
        progress.trackTintColor = .systemGray
        progress.progressTintColor = UIColor(named: "CustomColorPurple")
        progress.progressViewStyle = .bar
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupProgressBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        addSubview(textLabel)
        addSubview(progressLabel)
        addSubview(progressBar)
        
        NSLayoutConstraint.activate([
            
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            
            progressLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            progressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            progressBar.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 10),
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
        ])
    }
    
    func setupProgressBar(){
        // заполняем текущий процесс выполнения задач
        if Int(HabitsStore.shared.todayProgress * 100) == 0 {
            progressLabel.text = "0%"
        } else {
            progressLabel.text = String(Int(HabitsStore.shared.todayProgress * 100)) + "%"
        }
        progressBar.progress = HabitsStore.shared.todayProgress
    }
}
