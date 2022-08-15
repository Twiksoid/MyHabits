//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Nikita Byzov on 09.08.2022.
//
// деталка по причине

import UIKit

protocol HabitDetailsViewControllerForFirstSceneDelegate {
    func reloadAfterWatchDetails()
}

class HabitDetailsViewController: UIViewController {

    weak var firstViewController: HabitsViewController?
    weak var delegate: HabitsViewController?

    // лежит адрес ячейки в коллекции
    var indexPathCollection: IndexPath?

    //MARK: - Создается элемент для отображения

    private lazy var table: UITableView = {
        let table = UITableView(frame: .zero, style: .plain )
        table.backgroundColor = UIColor(named: "CustomColorLikeWhite")
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Header")
        table.register(TableActivitiesDetailsCell.self, forCellReuseIdentifier: "Default")
        table.delegate = self
        table.dataSource = self
        table.estimatedRowHeight = 60
        table.rowHeight = UITableView.automaticDimension
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }

    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if indexPathCollection != nil {setupNavigation(indexPathCollection!)}

        if indexPathCollection != nil && HabitsStore.shared.habits[indexPathCollection!.row].trackDates.count > 0 {createData(indexPathCollection!)}
    }

    func createData(_ indexPathCollection: IndexPath){
        var arrayOfIndexDate: [Int] = []
        for i in 0...HabitsStore.shared.habits[indexPathCollection.row].trackDates.count-1 {
            arrayOfIndexDate.append(i)
        }
    }

    //MARK: - Создание и настройка

    func setupNavigation(_ indexPathCollection: IndexPath){
        // тут должен быть тайтл таска, с которого переходим, его нужно задать, когда перейдем с прошлого контроллера
        navigationItem.title = HabitsStore.shared.habits[indexPathCollection.row].name
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font:
                UIFont.systemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor:
                UIColor.black
        ]

        let edit = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(goToEditMode))
        navigationItem.rightBarButtonItems = [edit]
    }

    @objc  func goToEditMode(){
        // лежит адрес ячейки в коллекции - indexPathCollection
        // лежит адрес ячейки в таблице деталки - indexPath
        // тут нужно будет пробросить indexPathCollection.row на след экран, чтобы к нему открыть верно причину для редактирования

        let viewNameToGo = HabitViewController()
        viewNameToGo.indexFromDetailView = indexPathCollection
        viewNameToGo.isEditing = true
        viewNameToGo.beginScene = firstViewController
        viewNameToGo.habitDetailsDelegate = self
        let goTo = UINavigationController(rootViewController: viewNameToGo)
        navigationController?.present(goTo, animated: true)
    }

    private func setupView(){
        view.addSubview(table)
        view.backgroundColor = .systemBackground
        NSLayoutConstraint.activate([
            
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

        ])
    }

}

//MARK: - Расширение, чтобы работать с таблицей

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Constants.headerOfDetailTaskTable
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (indexPathCollection != nil) {
            // количество дат к таску, с которого перешли в деталку, должен быть индекс
            return HabitsStore.shared.habits[indexPathCollection!.row].trackDates.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "Default", for: indexPath) as? TableActivitiesDetailsCell {
            let textFormat = DateFormatter()
            textFormat.dateStyle = .long
            cell.backgroundColor = .white
            cell.setupTextForCell(textFormat.string(from: HabitsStore.shared.habits[indexPathCollection!.row].trackDates[indexPath.row]))
            cell.setFirstMark(indexPath.row)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "someCell", for: indexPath)
            return cell
        }
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let cellForImageChanging = tableView.cellForRow(at: indexPath) as? TableActivitiesDetailsCell
        cellForImageChanging?.deselectAndSetMark()
    }
}

extension HabitDetailsViewController: HabitDetailsViewControllerDelegate {
    func backToMainScene() {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension HabitDetailsViewController: HabitsReturnDelegate {
    func backToInitViewController() {
        firstViewController?.reloadTaskCell()
    }

}
