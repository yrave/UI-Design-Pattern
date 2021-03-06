//
//  Student.swift
//  MVC-Student
//
//  Created by Yannick Rave on 19.02.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import Foundation

protocol StudentDelegate: class {
    func didChangeGradeAndAverage()
}

class Student {
    var firstName: String
    var lastName: String
    var grades: [Int] //0-100
    var studentID: Int
    
    weak var delegate: StudentDelegate?

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
        delegate?.didChangeGradeAndAverage()
    }
    
    var average: Int {
        guard self.grades.count > 0 else { return 0 }
        return self.grades.reduce(0, +) / self.grades.count
    }
}
