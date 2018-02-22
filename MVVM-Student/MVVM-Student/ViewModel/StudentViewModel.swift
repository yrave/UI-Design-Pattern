//
//  StudentViewModel.swift
//  MVVM-Student
//
//  Created by Yannick Rave on 19.02.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import Foundation

protocol StudentViewModelDelegate: class {
    func updateGradeInputText(text: String)
    func observeGradeAverage(text: String)
    func callObserveGrades(text: String)
}

class StudentViewModel {
    private let student: Student
    weak var delegate: StudentViewModelDelegate? {
        didSet {
            didChangeGradeAndAverage()
        }
    }
    
    init(student: Student? = nil) {
        self.student = student ?? Student(
            firstName: "John", lastName: "Doe",
            grades: [50, 50, 100, 60, 85], studentID: 123456)
        self.student.delegate = self
    }
    
    var fullName: String {
        return "\(student.firstName) \(student.lastName)"
    }
    
    var grades: String {
        return student.grades.map({ "\($0)" }).joined(separator: ", ")
    }
    
    var studentID: String {
        return "\(student.studentID)"
    }
    
    enum GradeError: Error {
        case invalidInput
    }
    
    func addGrade(text: String?) throws {
        guard let grade = text.flatMap({ Int($0) }) else { throw GradeError.invalidInput }
        try student.add(grade: grade)
        self.callUpdateGrade()
    }
    
    private func callUpdateGrade() {
        self.delegate?.updateGradeInputText(text: "")
    }
    private func callObserveGradeAverage() {
        self.delegate?.observeGradeAverage(text: "\(student.average)")
    }
    private func callObserveGrades() {
        self.delegate?.callObserveGrades(text: self.grades)
    }
}

extension StudentViewModel: StudentDelegate {
    func didChangeGradeAndAverage() {
        self.callObserveGrades()
        self.callObserveGradeAverage()
    }
}
