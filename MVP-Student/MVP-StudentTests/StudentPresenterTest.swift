//
//  StudentPresenterTest.swift
//  MVP-StudentTests
//
//  Created by Yannick Rave on 19.02.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import XCTest
@testable import MVP_Student

class StudentPresentableMock: StudentPresentable {
    var studentPresentableView: StudentPresentableView
    func showError() { }

    public init(studentPresentableView: StudentPresentableView) {
        self.studentPresentableView = studentPresentableView
    }
}

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
        grades: [50, 50, 100, 60, 85], studentID: 123456)
    
    lazy var view = StudentPresentableViewMock()
    lazy var presentable = StudentPresentableMock(studentPresentableView: self.view)
    lazy var presenter = StudentPresenter(presentable: self.presentable, student: self.student)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        presenter.startSetup()
    }

    func testFullName() {
        XCTAssertEqual(view.fullName, "John Doe")
        let abc = "ABC"
        presentable.studentPresentableView.setFullNameText(abc)
        XCTAssertEqual(view.fullName, abc)
    }
    
    func testIDName() {
        XCTAssertEqual(view.studentID, "123456")
    }
    
    func testGrades() {
        XCTAssertEqual(view.grades, "50, 50, 100, 60, 85")
    }
    
    func testNewGrades() {
        XCTAssertEqual(view.grades, "50, 50, 100, 60, 85")
        XCTAssertEqual(view.gpa, "69")
        presenter.addGrade(text: "1000")
        XCTAssertEqual(view.grades, "50, 50, 100, 60, 85")
        XCTAssertEqual(view.gpa, "69")
        presenter.addGrade(text: "100")
        XCTAssertEqual(view.grades, "50, 50, 100, 60, 85, 100")
        XCTAssertEqual(view.gpa, "74")
    }
}






