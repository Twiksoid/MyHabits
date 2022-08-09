//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Nikita Byzov on 07.08.2022.
//

// Экран привычки
import UIKit

class HabitsViewController: UIViewController {
    //MARK: - Задаем элементы, которые будем отображать
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //тут заголовок - прогресс collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Progress")
        //тут кастомные ячейки - задания collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        //collectionView.dataSource = self
        //collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    //MARK: - Задание и настройка
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
    }
    
    func setupView(){
        // цвет системы, для светлой темы будет белый
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func setupNavigationBar(){
        navigationItem.title = Constants.mainScreenTitle
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // создаю новый объект в верхнем баре
        let info = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTask))
        // крашу его в фиолетовый
        info.tintColor = UIColor(named: "CustomColorPurple")
        // добавляю его в доступные к выводу справа
        navigationItem.rightBarButtonItems = [info]
    }
    
    @objc private func addNewTask(){
        // тут вызываем экран создания записи
        let add = UINavigationController(rootViewController: HabitViewController())
        self.navigationController?.present(add, animated: true, completion: nil)
    }
}

//MARK: - Подпись на протокол - расширение класса HabitsViewController для работы с коллекцией

//extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
//  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//     return HabitsStore.shared.habits.count
//   }

// func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    if indexPath.section == 0 {
// должны кастомное вью прогресса показать
//     } else {
// показываем обычные ячейки
//  }

// if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Custom", for: indexPath) as? PhotosCollectionViewCell {
//    cell.setupCell(for: dataSourse[indexPath.row])
//   return cell
// } else {
//      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Default", for: indexPath)
//     return cell
//        }
//  }
