//
//  MVC_StudentTests.swift
//  MVC-StudentTests
//
//  Created by Yannick Rave on 19.02.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import XCTest
@testable import MVC_Student

class MVC_StudentTests: XCTestCase {
    
    let student = Student(firstName: "John", lastName: "Doe", grades: [80, 90], studentID: 3929)
    
    func testName() {
        XCTAssertEqual(student.firstName, "John")
        XCTAssertEqual(student.lastName, "Doe")
    }
    
    func testGrades() {
        XCTAssertEqual(student.grades, [80, 90])
    }
    
    func testStudentID() {
        XCTAssertEqual(student.studentID, 3929)
    }
    
    func testAverage() {
        XCTAssertEqual(student.average, 85)
    }
    
    func testNewGrade() {
        XCTAssertNoThrow(try student.add(grade: 100))
        XCTAssertEqual(student.average, 90)
        XCTAssertEqual(student.grades, [80, 90, 100])
        
        XCTAssertThrowsError(try student.add(grade: 1000))
        XCTAssertThrowsError(try student.add(grade: -1000))
        XCTAssertEqual(student.average, 90)
        XCTAssertEqual(student.grades, [80, 90, 100])
        
        let studentNoGrades = Student(firstName: "", lastName: "", grades: [], studentID: 0)
        XCTAssertEqual(studentNoGrades.average, 0)
    }
}
