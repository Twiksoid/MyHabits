//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Nikita Byzov on 10.08.2022.
//
// сама ячейка (как выглядит) таска

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    private lazy var taskName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = ""
        label.sizeToFit()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var repeatTime: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var counter: UILabel = {
        let label = UILabel()
        label.text = "Счётчик: 0"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        image.layer.cornerRadius = 10
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    @objc func imageTapped(){
        if HabitsStore.shared.habits[image.tag].isAlreadyTakenToday {
            // только принт сделаем, пользователю ничего не покажем
            print("Уже трекано")
        } else {
            HabitsStore.shared.track(HabitsStore.shared.habits[image.tag])
            updateImageOfTask(image.tag)
            updateCounterOfTask(image.tag)
            // слушатель как раз обновит прогресс-бар
            NotificationCenter.default.post(name: Notification.Name(rawValue: notificationKeyForCellUpdate), object: self)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        addSubview(taskName)
        addSubview(repeatTime)
        addSubview(counter)
        addSubview(image)
        
        NSLayoutConstraint.activate([
            taskName.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            taskName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            taskName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            
            repeatTime.topAnchor.constraint(equalTo: taskName.bottomAnchor, constant: 4),
            repeatTime.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            counter.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            counter.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            image.heightAnchor.constraint(equalToConstant: 36),
            image.widthAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    func setupCellForTask(_ index: Int){
        taskName.textColor = HabitsStore.shared.habits[index].color
        taskName.text = HabitsStore.shared.habits[index].name
        repeatTime.text = HabitsStore.shared.habits[index].dateString
        // нумеруем изображения равным номеру ячейки, в которой оно отображается
        image.tag = index
        updateCounterOfTask(index)
        updateImageOfTask(index)
    }
    
    func updateCounterOfTask(_ index: Int) {
        counter.text = "Счётчик: \(String(HabitsStore.shared.habits[index].trackDates.count))"
    }
    
    func updateImageOfTask(_ index: Int){
        if HabitsStore.shared.habits[index].isAlreadyTakenToday {
            image.image = UIImage(systemName: "checkmark.circle.fill")
            image.tintColor = HabitsStore.shared.habits[index].color
        } else {
            image.image = UIImage(systemName: "circle")
            image.tintColor = HabitsStore.shared.habits[index].color
        }
    }
}
