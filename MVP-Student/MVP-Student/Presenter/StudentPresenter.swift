//
//  StudentPresenter.swift
//  MVP-Student
//
//  Created by Yannick Rave on 19.02.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import Foundation

class StudentPresenter {
    private weak var studentView: StudentPresentableView!
    private var student: Student
    
    init(studentView: StudentPresentableView, student: Student) {
        self.studentView = studentView
        self.student = student
        student.delegate = self
    }
    
    func setupStudent() {
        self.studentView.setFullNameText("\(self.student.firstName) \(self.student.lastName)")
        self.studentView.setStudentIDText("\(student.studentID)")
        self.studentView.setAllGradesText(student.grades.map({ "\($0)" }).joined(separator: ", "))
        self.studentView.setGradePointAverageText("\(student.average)")
    }

    private func addGrade(text: String?) throws {
        guard let grade = text.flatMap({ Int($0) }) else { throw GradeError.invalidInput }
        try student.add(grade: grade)
        studentView.newGradeTextFieldText = ""        
    }
    
    func didSelectAddButton(text: String?) {
        do {
            try self.addGrade(text: text)
        } catch { } //TODO: Show error
    }
    enum GradeError: Error {
        case invalidInput
    }
}

extension StudentPresenter: StudentDelegate {
    func didChangeGradeAndAverage() {
        self.setupStudent()
    }
}
