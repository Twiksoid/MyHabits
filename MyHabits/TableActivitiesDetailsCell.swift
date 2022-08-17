//
//  TableActivitiesDetailsCell.swift
//  MyHabits
//
//  Created by Nikita Byzov on 11.08.2022.
//  Кастомная ячейка для таблицы-деталки (где время отображается)

import UIKit

class TableActivitiesDetailsCell: UITableViewCell {
    private lazy var textForCell: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 14)
        title.textAlignment = .left
        title.textColor = .black
        title.text = ""
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var imageCheck: UIImageView = {
        let image = UIImageView()
        image.tintColor = UIColor(named: "CustomColorPurple")
        image.image = UIImage(systemName: "checkmark")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        contentView.addSubview(textForCell)
        contentView.addSubview(imageCheck)
        
        NSLayoutConstraint.activate([
            
            textForCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11),
            textForCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textForCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -11),
            
            imageCheck.centerYAnchor.constraint(equalTo: textForCell.centerYAnchor),
            imageCheck.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14)
        ])
    }
    
    func setupTextForCell(_ habit: Habit, _ data: Date){
        let textFormat = DateFormatter()
        textFormat.dateStyle = .long
        textForCell.text = textFormat.string(from: data)
        
        if HabitsStore.shared.habit(habit, isTrackedIn: data) {
            imageCheck.isHidden = false
        } else {
            imageCheck.isHidden = true
        }
    }
}
