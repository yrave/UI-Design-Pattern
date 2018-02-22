//
//  StudentPresenterTest.swift
//  MVP-StudentTests
//
//  Created by Yannick Rave on 19.02.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import XCTest
@testable import MVP_Student

class StudentPresentableViewMock: StudentPresentableView {
    var fullName: String = ""
    var gpa: String = ""
    var grades: String = ""
    var studentID: String = ""
    
    func setFullNameText(_ value: String) {
        self.fullName = value
    }
    
    func setGradePointAverageText(_ value: String) {
        self.gpa = value
    }
    
    func setAllGradesText(_ value: String) {
        self.grades = value
    }
    
    func setStudentIDText(_ value: String) {
        self.studentID = value
    }
    
    var newGradeTextFieldText: String? = "ABC"
}

class StudentPresenterTest: XCTestCase {
    
    let student = Student(
        firstName: "John", lastName: "Doe",
        grades: [], studentID: 123456)
    
    lazy var view = StudentPresentableViewMock()
    lazy var presenter = StudentPresenter(studentView: self.view, student: self.student)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        presenter.startSetup()
    }

    func testFullName() {
        XCTAssertEqual(view.fullName, "John Doe")
        
        let abc = "ABC"
        view.setFullNameText(abc)
        XCTAssertEqual(view.fullName, abc)
    }
    
    func testIDName() {
        XCTAssertEqual(view.studentID, "123456")
        
        let id = "123"
        view.setStudentIDText(id)
        XCTAssertEqual(view.studentID, id)
    }
    
    func testGrades() {
        XCTAssertEqual(view.grades, "")
        ["50", "100"].forEach({ presenter.textFieldShouldReturn(text: $0) })
        XCTAssertEqual(view.grades, "50, 100")
    }
    
    func testGPA() {
        XCTAssertEqual(view.gpa, "0")
        ["50", "100"].forEach({ presenter.textFieldShouldReturn(text: $0) })
        XCTAssertEqual(view.gpa, "75")
    }
    
    func testNewGrades() {
        XCTAssertEqual(view.grades, "")
        XCTAssertEqual(view.gpa, "0")
        ["50", "100"].forEach({ presenter.textFieldShouldReturn(text: $0) })

        
        presenter.textFieldShouldReturn(text: "1000")
        XCTAssertEqual(view.grades, "50, 100")
        XCTAssertEqual(view.gpa, "75")
        
        presenter.textFieldShouldReturn(text: "100")
        XCTAssertEqual(view.grades, "50, 100, 100")
        XCTAssertEqual(view.gpa, "83")
        
        presenter.textFieldShouldReturn(text: "-30")
        XCTAssertEqual(view.grades, "50, 100, 100")
        XCTAssertEqual(view.gpa, "83")
        
        presenter.textFieldShouldReturn(text: "abc")
        XCTAssertEqual(view.grades, "50, 100, 100")
        XCTAssertEqual(view.gpa, "83")
    }
}
