//
//  AddTaskViewController.swift
//  SmartToDo
//
//  Created by Disha  on 05/02/26.
//

import UIKit

// Author: Dishaben Patel
// Student ID: 101410018
// Course: COMP3097

protocol AddTaskDelegate: AnyObject {
    func didAddTask(_ task: Task)
}

class AddTaskViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!

    weak var delegate: AddTaskDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Creates a new task and sends it back to the main screen
    @IBAction func saveTask(_ sender: UIButton) {
        guard let title = titleTextField.text, !title.isEmpty else {
            return
        }

        let newTask = Task(title: title, dueDate: datePicker.date, isCompleted: false)
        delegate?.didAddTask(newTask)

        navigationController?.popViewController(animated: true)
    }
}
