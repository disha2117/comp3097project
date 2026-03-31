//
//  TaskDetailsViewController.swift
//  SmartToDo
//
//  Created by  Disha on 05/02/26.
//

import UIKit

// Author: Dishaben Patel
// Student ID: 101410018
// Course: COMP3097

protocol TaskDetailsDelegate: AnyObject {
    func didUpdateTask(_ task: Task, at index: Int)
    func didDeleteTask(at index: Int)
}

class TaskDetailsViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var completedSwitch: UISwitch!

    var task: Task?
    var taskIndex: Int?
    weak var delegate: TaskDetailsDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let task = task {
            titleTextField.text = task.title
            datePicker.date = task.dueDate
            completedSwitch.isOn = task.isCompleted
        }
    }

    // Updates existing task
    @IBAction func updateTask(_ sender: UIButton) {
        guard let title = titleTextField.text,
              !title.isEmpty,
              let index = taskIndex else { return }

        let updatedTask = Task(
            title: title,
            dueDate: datePicker.date,
            isCompleted: completedSwitch.isOn
        )

        delegate?.didUpdateTask(updatedTask, at: index)
        navigationController?.popViewController(animated: true)
    }

    // Deletes task
    @IBAction func deleteTask(_ sender: UIButton) {
        guard let index = taskIndex else { return }

        delegate?.didDeleteTask(at: index)
        navigationController?.popViewController(animated: true)
    }
}
