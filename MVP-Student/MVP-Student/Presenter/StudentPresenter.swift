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
        studentView.delegate = self
        student.delegate = self
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
        self.studentView.setGradePointAverageText("\(student.average)")
    }
    
    enum GradeError: Error {
        case invalidInput
    }

    private func addGrade(text: String?) throws {
        guard let grade = text.flatMap({ Int($0) }) else { throw GradeError.invalidInput }
        try student.add(grade: grade)
        studentView.newGradeTextFieldText = ""        
    }
}

extension StudentPresenter: StudentViewDelegate {
    func didSelectAddButton(text: String?) {
        do {
            try self.addGrade(text: text)
        } catch { } //TODO: Show error
    }
}

extension StudentPresenter: StudentDelegate {
    func didChangeGradeAndAverage() {
        self.setupStudentGrades()
    }
}
