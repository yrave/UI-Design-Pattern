//
//  StudentViewModel.swift
//  MVVM-Student
//
//  Created by Yannick Rave on 19.02.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import Foundation

class StudentViewModel {
    private let student = Student(
        firstName: "John", lastName: "Doe",
        grades: [50, 50, 100, 60, 85], studentID: 123456)
    
    var updateGradeInputText: (String) -> ()
    var observeGradeAverage: (String) -> ()
    var observeGrades: (String) -> ()
    
    init(updateGradeInputText: @escaping (String) -> (), observeGradeAverage: @escaping (String) -> (), observeGrades: @escaping (String) -> ()) {
        self.updateGradeInputText = updateGradeInputText
        self.observeGradeAverage = observeGradeAverage
        self.observeGrades = observeGrades
        
        self.updateObservers()
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
        self.observeGrades(self.grades)
        self.observeGradeAverage(self.avg)
        self.updateGradeInputText("")
    }
    
    func addGrade(text: String?) throws {
        guard let grade = text.flatMap({ Int($0) }) else { throw GradeError.invalidInput }
        try student.add(grade: grade)
        updateObservers()
    }
}

