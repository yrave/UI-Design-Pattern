//
//  StudentPresenter.swift
//  MVP-Student
//
//  Created by Yannick Rave on 19.02.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import Foundation
import UIKit

class StudentPresenter {

    init(studentView: StudentPresentableView, student: Student) {
        self.studentView = studentView
        self.student = student
    }

    private weak var studentView: StudentPresentableView!

    private var student: Student

    private func setupStudent() {
        self.studentView.setFullNameText("\(self.student.firstName) \(self.student.lastName)")
        self.studentView.setStudentIDText("\(student.studentID)")
    }
    
    public func startSetup() {
        setupStudentGrades()
        setupStudent()
    }

    private func setupStudentGrades() {
        self.studentView.setAllGradesText(student.grades.map({ "\($0)" }).joined(separator: ", "))
        self.studentView.setGradePointAverageText("\(student.grades.reduce(0, +) / student.grades.count)")
    }
    
    enum GradeError: Error {
        case invalidInput
    }

    func addGrade(text: String?) throws {
        guard let grade = text.flatMap({ Int($0) }) else { throw GradeError.invalidInput }
        try student.add(grade: grade)
        setupStudentGrades()
        studentView.newGradeTextFieldText = ""        
    }
}
