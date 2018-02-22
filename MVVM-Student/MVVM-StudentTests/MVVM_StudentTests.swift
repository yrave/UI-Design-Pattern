//
//  MVVM_StudentTests.swift
//  MVVM-StudentTests
//
//  Created by Yannick Rave on 19.02.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import XCTest
@testable import MVVM_Student

class StudentViewMock: StudentViewModelDelegate {
    var newGrade = ""
    var average = ""
    var allGrades = ""
    
    func updateGradeInputText(text: String) {
        newGrade = text
    }
    
    func observeGradeAverage(text: String) {
        average = text
    }
    
    func callObserveGrades(text: String) {
        allGrades = text
    }
}

class MVVM_StudentTests: XCTestCase {
    
    let student = Student(
        firstName: "Max", lastName: "Meier",
        grades: [40, 40, 80, 60, 85], studentID: 12345678)
    
    var viewModel: StudentViewModel!
    let mock = StudentViewMock()
    
    override func setUp() {
        super.setUp()
        viewModel = StudentViewModel(student: student)
        viewModel.delegate = mock
    }
    
    func testFullName() {
        XCTAssertEqual(viewModel.fullName, "Max Meier")
    }
    
    func testStudentID() {
        XCTAssertEqual(viewModel.studentID, "12345678")
    }
    
    func testZeroGrades() {
        let vm = StudentViewModel(student: Student(firstName: "", lastName: "", grades: [], studentID: 0))
        vm.delegate = mock
        
        XCTAssertEqual(mock.average, "0")
        XCTAssertEqual(mock.allGrades, "")
    }
    
    func testNewGrade() {
        XCTAssertEqual(mock.allGrades, "40, 40, 80, 60, 85")
        XCTAssertEqual(mock.average, "61")
        
        mock.newGrade = "100"
        try? viewModel.addGrade(text: mock.newGrade)
        XCTAssertEqual(mock.allGrades, "40, 40, 80, 60, 85, 100")
        XCTAssertEqual(mock.average, "67")
        XCTAssertEqual(mock.newGrade, "")
        
        try? viewModel.addGrade(text: "-30")
        XCTAssertEqual(mock.allGrades, "40, 40, 80, 60, 85, 100")
        XCTAssertEqual(mock.average, "67")
        
        try? viewModel.addGrade(text: "200")
        XCTAssertEqual(mock.allGrades, "40, 40, 80, 60, 85, 100")
        XCTAssertEqual(mock.average, "67")
        
        XCTAssertThrowsError(try viewModel.addGrade(text: "Hi"))
        XCTAssertEqual(mock.allGrades, "40, 40, 80, 60, 85, 100")
        XCTAssertEqual(mock.average, "67")
    }
}
