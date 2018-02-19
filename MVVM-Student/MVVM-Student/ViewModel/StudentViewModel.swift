//
//  StudentViewModel.swift
//  MVVM-Student
//
//  Created by Yannick Rave on 19.02.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import Foundation

class StudentViewModel {
    private let student: Student
    var updateGradeInputText: ((String) -> ())?
    private func callUpdateGrade() {
        self.updateGradeInputText?("")
    }
    var observeGradeAverage: ((String) -> ())? {
        didSet { self.callObserveGradeAverage() }
    }
    private func callObserveGradeAverage() {
        self.observeGradeAverage?(self.avg)
    }
    var observeGrades: ((String) -> ())? {
        didSet { self.callObserveGrades() }
    }
    private func callObserveGrades() { self.observeGrades?(self.grades) }
    
    init(student: Student? = nil) {
        self.student = student ?? Student(
            firstName: "John", lastName: "Doe",
            grades: [50, 50, 100, 60, 85], studentID: 123456)
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
    
    var avg: String {
        return "\(student.grades.reduce(0, +) / student.grades.count)"
    }
    
    enum GradeError: Error {
        case invalidInput
    }
    
    fileprivate func updateObservers() {
        self.callUpdateGrade()
        self.callObserveGradeAverage()
        self.callObserveGrades()
    }
    
    func addGrade(text: String?) throws {
        guard let grade = text.flatMap({ Int($0) }) else { throw GradeError.invalidInput }
        try student.add(grade: grade)
        updateObservers()
    }
}

