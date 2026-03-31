//
//  ViewController.swift
//  SmartToDo
//
//  Created by Disha  on 05/02/26.
//

import UIKit

// Author: Dishaben Patel
// Student ID: 101410018
// Course: COMP3097

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var tasks: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        loadTasks()
    }

    // Returns number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    // Displays each task in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)

        let task = tasks[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateStyle = .medium

        let status = task.isCompleted ? "✅" : "⭕️"
        cell.textLabel?.text = "\(status) \(task.title) - \(formatter.string(from: task.dueDate))"

        return cell
    }

    // Handles row tap and opens details screen
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetails", sender: indexPath)
    }

    // Passes data to next screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAddTask" {
            let destination = segue.destination as! AddTaskViewController
            destination.delegate = self
        }

        if segue.identifier == "goToDetails" {
            let destination = segue.destination as! TaskDetailsViewController
            if let indexPath = sender as? IndexPath {
                destination.task = tasks[indexPath.row]
                destination.taskIndex = indexPath.row
                destination.delegate = self
            }
        }
    }

    // Saves tasks using UserDefaults
    func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: "tasks")
        }
    }

    // Loads tasks when app starts
    func loadTasks() {
        if let data = UserDefaults.standard.data(forKey: "tasks"),
           let savedTasks = try? JSONDecoder().decode([Task].self, from: data) {
            tasks = savedTasks
        }
    }
}

// Add Task delegate
extension ViewController: AddTaskDelegate {
    func didAddTask(_ task: Task) {
        tasks.append(task)
        saveTasks()
        tableView.reloadData()
    }
}

// Task Details delegate
extension ViewController: TaskDetailsDelegate {
    func didUpdateTask(_ task: Task, at index: Int) {
        tasks[index] = task
        saveTasks()
        tableView.reloadData()
    }

    func didDeleteTask(at index: Int) {
        tasks.remove(at: index)
        saveTasks()
        tableView.reloadData()
    }
}
