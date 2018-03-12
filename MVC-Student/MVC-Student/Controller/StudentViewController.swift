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
        
        studentView.delegate = self
        student.delegate = self
        setupStudent()
    }

    func setupStudent() {
        self.studentView.fullNameLabel.text = "\(self.student.firstName) \(self.student.lastName)"
        self.studentView.studentIDLabel.text = "\(student.studentID)"
        setupStudentGrades()
    }
    
    func setupStudentGrades() {
        self.studentView.allGradesLabel.text = student.grades.map({ "\($0)" }).joined(separator: ", ")
        self.studentView.gradePointAverageLabel.text = "\(student.average)"
    }
}

extension StudentViewController: StudentViewDelegate {
    enum GradeError: Error { case invalidInput }
    func didSelectAddButton(text: String?) {
        do {
            guard let grade = text.flatMap({ Int($0) })
                else { throw GradeError.invalidInput }
            try student.add(grade: grade)
            studentView.newGradeTextField.text = ""
        } catch { } //TODO: Show error
    }
}

extension StudentViewController: StudentDelegate {
    func didChangeGradeAndAverage() {
        self.setupStudentGrades()
    }
}
