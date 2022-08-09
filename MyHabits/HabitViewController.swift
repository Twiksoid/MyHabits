//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Nikita Byzov on 08.08.2022.
//

import UIKit

class HabitViewController: UIViewController {
    
    private lazy var titleText: UITextField = {
        let text = UITextField()
        text.text = Constants.name
        text.isEnabled = false
        text.font = .systemFont(ofSize: 16)
        text.textColor = .black
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var labelText: UITextField = {
        let label = UITextField()
        label.isEnabled = true
        label.placeholder = Constants.placeholder
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(named: "CustomColorBlue")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var colorText: UITextField = {
        let text = UITextField()
        text.text = Constants.color
        text.isEnabled = false
        text.font = .systemFont(ofSize: 16)
        text.textColor = .black
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var pickerColorButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.backgroundColor = UIColor(named: "CustomColorOrange")
        button.addTarget(self, action: #selector(goToPicker), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func goToPicker(){
        
        let colorPickerVC = UIColorPickerViewController()
        // когда откроется палитра, будет выбран белый
        colorPickerVC.selectedColor = .systemBackground
        colorPickerVC.delegate = self
        present(colorPickerVC, animated: true)
    }
    
    private lazy var timeText: UITextField = {
        let text = UITextField()
        text.text = Constants.time
        text.isEnabled = false
        text.font = .systemFont(ofSize: 16)
        text.textColor = .black
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var everyTimeText: UITextField = {
        let text = UITextField()
        text.text = Constants.everyDayIn
        text.isEnabled = false
        text.font = .systemFont(ofSize: 16)
        text.textColor = .black
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    private lazy var timeValue: UILabel = {
        let text = UILabel()
        text.font = .systemFont(ofSize: 16)
        text.textColor = UIColor(named: "CustomColorPurple")
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    private lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .time
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        return picker
    }()

    @objc private func timeChanged(){
        let timeFormat = DateFormatter()
        timeFormat.timeStyle = .short
        timeValue.text = timeFormat.string(from: timePicker.date)
    }

    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    @objc private func showKeyboard(_ notification: Notification){
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height

            let bottomPointYOfPicker = timePicker.frame.origin.y + timePicker.frame.height
            let keyboardOriginY = view.frame.height - keyboardHeight - 45

            var offSet: CGFloat = CGFloat()
            if keyboardOriginY <= bottomPointYOfPicker {
                offSet = bottomPointYOfPicker - keyboardOriginY
            }
            scrollView.contentOffset = CGPoint(x: 0, y: offSet)
        }
    }

    private func setupGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func hideKeyboard(){
        view.endEditing(true)
        scrollView.setContentOffset(.zero, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
        setupGesture()
    }
    
    func setupView(){
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(titleText)
        scrollView.addSubview(labelText)
        scrollView.addSubview(colorText)
        scrollView.addSubview(pickerColorButton)
        scrollView.addSubview(timeText)
        scrollView.addSubview(everyTimeText)
        scrollView.addSubview(timePicker)
        scrollView.addSubview(timeValue)

        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),

            titleText.topAnchor.constraint(equalTo: scrollView.topAnchor),
            titleText.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),

            labelText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 8),
            labelText.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),

            colorText.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 8),
            colorText.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),

            pickerColorButton.topAnchor.constraint(equalTo: colorText.bottomAnchor, constant: 8),
            pickerColorButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            pickerColorButton.widthAnchor.constraint(equalToConstant: 40),
            pickerColorButton.heightAnchor.constraint(equalToConstant: 40),

            timeText.topAnchor.constraint(equalTo: pickerColorButton.bottomAnchor, constant: 8),
            timeText.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),

            everyTimeText.topAnchor.constraint(equalTo: timeText.bottomAnchor, constant: 8),
            everyTimeText.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),

            timePicker.topAnchor.constraint(equalTo: everyTimeText.bottomAnchor),
            timePicker.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

            timeValue.leadingAnchor.constraint(equalTo: everyTimeText.trailingAnchor, constant: 5),
            timeValue.bottomAnchor.constraint(equalTo: everyTimeText.bottomAnchor)
            
        ])
    }
    
    func setupNavigationBar(){
        navigationItem.title = Constants.createTitle
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        
        // создаю новый объект в верхнем баре
        let cansel = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(canselAddTask))
        let save = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveAddTask))
        
        // крашу его в фиолетовый
        cansel.tintColor = UIColor(named: "CustomColorPurple")
        save.tintColor = UIColor(named: "CustomColorPurple")
        
        // добавляю его в доступные к выводу справа и слева
        navigationItem.rightBarButtonItems = [save]
        navigationItem.leftBarButtonItems = [cansel]
    }
    
    @objc private func canselAddTask(){
        dismiss(animated: true)
    }
    
    @objc private func saveAddTask(){}
    
}

// чтобы пикер цвета работал
extension HabitViewController: UIColorPickerViewControllerDelegate {
    // что сделать, когда выбрал цвет
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        // нужно будет присвоить выбранный цвет иконке
        let currentSelectedColor = viewController.selectedColor
        pickerColorButton.backgroundColor = currentSelectedColor
    }
    // что делать, когда перебираешь цвета
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let currentSelectedColor = viewController.selectedColor
        pickerColorButton.backgroundColor = currentSelectedColor
    }
}
