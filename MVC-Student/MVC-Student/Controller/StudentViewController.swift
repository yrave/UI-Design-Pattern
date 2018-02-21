//
//  StudentViewController.swift
//  MVC-Student
//
//  Created by Yannick Rave on 19.02.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import UIKit

class StudentViewController: UIViewController {
    
    @IBOutlet var studentView: StudentView!
    let student = Student(
        firstName: "John", lastName: "Doe",
        grades: [50, 50, 100, 60, 85], studentID: 123456)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStudent()
        studentView.newGradeTextField.delegate = self
    }

    func setupStudent() {
        self.studentView.fullNameLabel.text = "\(self.student.firstName) \(self.student.lastName)"
        self.studentView.studentIDLabel.text = "\(student.studentID)"
        setupStudentGrades()
    }
    
    func setupStudentGrades() {
        self.studentView.allGradesLabel.text = student.grades.map({ "\($0)" }).joined(separator: ", ")
        self.studentView.gradePointAverageLabel.text = "\(self.average())"
    }
    
    func average() -> Int {
        guard student.grades.count > 0 else { return 0 }
        return student.grades.reduce(0, +) / student.grades.count
    }
}

extension StudentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let grade = textField.text.flatMap({ Int($0) }) else { return true } //TODO: Show error
        do {
            try student.add(grade: grade)
            setupStudentGrades()
            textField.text = ""
        } catch { } //TODO: Show error
        return true
    }
}
