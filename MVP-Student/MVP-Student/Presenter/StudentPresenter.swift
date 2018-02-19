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

    init(presentable: StudentPresentable, student: Student) {
        self.presentable = presentable
        self.studentView = presentable.studentPresentableView
        self.student = student
        setupStudent()
    }

    private weak var presentable: StudentPresentable!
    private weak var studentView: StudentPresentableView!

    private var student: Student

    private func setupStudent() {
        self.studentView.setFullNameText("\(self.student.firstName) \(self.student.lastName)")
        self.studentView.setStudentIDText("\(student.studentID)")
        setupStudentGrades()
    }

    private func setupStudentGrades() {
        self.studentView.setAllGradesText(student.grades.map({ "\($0)" }).joined(separator: ", "))
        self.studentView.setGradePointAverageText("\(student.grades.reduce(0, +) / student.grades.count)")
    }

    func addGrade(text: String?) {
        guard let grade = text.flatMap({ Int($0) }) else {
            presentable.showError()
            return
        }
        do {
            try student.add(grade: grade)
            setupStudentGrades()
            studentView.newGradeTextFieldText = ""
        } catch {
            presentable.showError()
        }
    }
}
