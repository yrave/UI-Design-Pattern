//
//  MVVM_StudentTests.swift
//  MVVM-StudentTests
//
//  Created by Yannick Rave on 19.02.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import XCTest
@testable import MVVM_Student

class MVVM_StudentTests: XCTestCase {
    
    let student = Student(
        firstName: "Max", lastName: "Meier",
        grades: [40, 40, 80, 60, 85], studentID: 12345678)
    
    var viewModel: StudentViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = StudentViewModel(student: student)
    }
    
    func testFullName() {
        XCTAssertEqual(viewModel.fullName, "Max Meier")
    }
    
    func testStudentID() {
        XCTAssertEqual(viewModel.studentID, "12345678")
    }
    
    func testNewGrade() {
        var grades: String!
        var avg: String!
        var input = "100"
        viewModel.observeGrades = { grades = $0 }
        viewModel.observeGradeAverage = { avg = $0 }
        viewModel.updateGradeInputText = { input = $0 }
        
        XCTAssertEqual(grades, "40, 40, 80, 60, 85")
        XCTAssertEqual(avg, "61")
        
        try? viewModel.addGrade(text: input)
        XCTAssertEqual(grades, "40, 40, 80, 60, 85, 100")
        XCTAssertEqual(avg, "67")
        XCTAssertEqual(input, "")
        
        try? viewModel.addGrade(text: "Hi")
        XCTAssertEqual(grades, "40, 40, 80, 60, 85, 100")
        XCTAssertEqual(avg, "67")
        
        try? viewModel.addGrade(text: "-30")
        XCTAssertEqual(grades, "40, 40, 80, 60, 85, 100")
        XCTAssertEqual(avg, "67")
        
        try? viewModel.addGrade(text: "200")
        XCTAssertEqual(grades, "40, 40, 80, 60, 85, 100")
        XCTAssertEqual(avg, "67")
    }
    
}
