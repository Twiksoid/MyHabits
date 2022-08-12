//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Nikita Byzov on 07.08.2022.
//

// Экран привычек
import UIKit

protocol DelegateCollectionCellIndex {
    var indexPathCell: IndexPath { get set }
}

class HabitsViewController: UIViewController {
    var indexPathCell: DelegateCollectionCellIndex?
    
    //MARK: - Задаем элементы, которые будем отображать
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 18
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "ProgressBar")
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "CellForTask")
        collectionView.layer.cornerRadius = 10
        collectionView.layer.borderColor = UIColor(named: "CustomColorLikeWhite")?.cgColor
        collectionView.layer.borderWidth = 5
        collectionView.backgroundColor = UIColor(named: "CustomColorLikeWhite")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    //MARK: - Задание и настройка
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        reloadData()
    //    }
    
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

extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {return 1} else {
            print("Количество тасков - ", HabitsStore.shared.habits.count)
            return HabitsStore.shared.habits.count
        }}
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgressBar", for: indexPath) as? ProgressCollectionViewCell {
                cell.setupProgressBar()
                cell.layer.cornerRadius = 10
                cell.backgroundColor = .white
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Default", for: indexPath)
                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellForTask", for: indexPath) as? HabitCollectionViewCell {
                cell.layer.cornerRadius = 10
                cell.backgroundColor = .white
                
                cell.setupCellForTask(indexPath.row)
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Default", for: indexPath)
                return cell
            }
        }
    }
    func reloadData(){
        collectionView.reloadData()
        print("catched")
        view.layoutIfNeeded()
        view.setNeedsDisplay()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section > 0 {
            let vc = HabitDetailsViewController()
            vc.indexPathCollection = indexPath
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // чтобы ширина автоматически подбиралась под рамзеры устройства
        let insets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let interItemSpacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        let width = collectionView.frame.width - (1 - 1) * interItemSpacing - insets.left - insets.right
        let itemWidth = floor(width / 1)
        // для ячейки со статус баром кастомная высота - 10% ширины устройства. Для остальных - 31%
        if indexPath.section == 0 { let height = collectionView.frame.height * 0.1
            return CGSize(width: itemWidth, height: height)
        } else {
            return CGSize(width: itemWidth, height: itemWidth*0.31)
        }}
}

