//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Nikita Byzov on 09.08.2022.
//

import UIKit

// деталка по причине

class HabitDetailsViewController: UIViewController {

    //MARK: - Создается элемент для отображения

    private lazy var table: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.estimatedRowHeight = 40
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    //MARK: - Создание и настройка


    private func setupNavigation(){
        // тут должен быть тайтл таска, с которого переходим, его нужно задать, когда перейдем с прошлого контроллера
        //navigationItem.title = Constants.detailTitle
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false

        let edit = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(goToEditMode))
        edit.tintColor = UIColor(named: "CustomColorPurple")
        navigationItem.rightBarButtonItem = edit
    }

    @objc private func goToEditMode(){
        let edit = UINavigationController(rootViewController: HabitViewController())
        navigationController?.present(edit, animated: true, completion: nil)

    }

    private func setupView(){
        view.addSubview(table)
        NSLayoutConstraint.activate([
            
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }

}

//MARK: - Расширение, чтобы работать с таблицей


extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // количество дат к таску, с которого перешли в деталку, вместо 0 должен быть индекс верный
        return HabitsStore.shared.habits[0].trackDates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Default", for: indexPath)
        // тут нужно в каждую ячейку вернуть соответствующую дату
        // не понятно, как сделать. Возможно, создать массив, в массив переложить все даты, а потом вытаскивать как раз так, как написано ниже
        //cell.textLabel?.text = someArray[indexPath.row]
        // или как-то напрямую пытаться
        //cell.textLabel?.text = HabitsStore.shared.habits[0].trackDates[indexPath.row]
        return cell
    }


}
