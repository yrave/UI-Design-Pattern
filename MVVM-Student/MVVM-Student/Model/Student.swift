//
//  Student.swift
//  MVVM-Student
//
//  Created by Yannick Rave on 19.02.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import Foundation

class Student {
    var firstName: String
    var lastName: String
    var grades: [Int] //0-100
    var studentID: Int

    init(firstName: String, lastName: String, grades: [Int], studentID: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.grades = grades
        self.studentID = studentID
    }
    
    enum GradeError: Error {
        case tooLow, tooHigh
    }
    
    func add(grade: Int) throws {
        guard grade <= 100 else { throw GradeError.tooHigh }
        guard grade >= 0 else { throw GradeError.tooLow }
        self.grades.append(grade)
    }
}
