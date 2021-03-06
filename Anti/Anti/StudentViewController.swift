//
//  StudentViewController.swift
//  Anti
//
//  Created by Yannick Rave on 21.02.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import UIKit

class StudentViewController: UIViewController {

    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var gradesLabel: UILabel!
    @IBOutlet var studentIDLabel: UILabel!
    @IBOutlet var averageLabel: UILabel!
    @IBOutlet var newGradeTextField: UITextField!
    @IBOutlet var addButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fullNameLabel.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        self.addButton.addTarget(self, action: #selector(addGrade), for: .touchUpInside)
        
        fullNameLabel.text = "John Doe"
        studentIDLabel.text = "12393"
        gradesLabel.text = "20, 60, 40, 100, 93"
        calcAverage()
    }
    
    func calcAverage() {
        let numbers = (gradesLabel.text ?? "")
            .components(separatedBy: ",")
            .map({ $0.trimmingCharacters(in: .whitespaces) })
            .flatMap({ Int($0) })
        guard numbers.count > 0 else {
            averageLabel.text = "0"
            return
        }
        let average = numbers.reduce(0, +) / numbers.count
        averageLabel.text = "\(average)"
    }

    enum GradeError: Error {
        case tooLow, tooHigh
    }
    
    func add(grade: Int) throws {
        guard grade <= 100 else { throw GradeError.tooHigh }
        guard grade >= 0 else { throw GradeError.tooLow }
        self.gradesLabel.text = "\(self.gradesLabel.text ?? ""), \(grade)"
        calcAverage()
    }
    
    @objc func addGrade() {
        guard let grade = self.newGradeTextField.text.flatMap({ Int($0) }) else{ return } //TODO: Show error
        do {
            try self.add(grade: grade)
            self.newGradeTextField.text = ""
        } catch { } //TODO: Show error
    }
}
