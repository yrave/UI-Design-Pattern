//
//  MVVM_RxSwift_StudentTests.swift
//  MVVM-RxSwift-StudentTests
//
//  Created by Yannick Rave on 01.03.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
@testable import MVVM_RxSwift_Student

class MVVM_RxSwift_StudentTests: XCTestCase {
    let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
    }
    
    func testStudent() {        
        let student = Student(firstName: "Hi", lastName: "Ab", grades: [], studentID: 47)
        let viewModel = StudentViewModel(student: student)
        
        let scheduler = TestScheduler(initialClock: 0)
        let fn = scheduler.createObserver(String.self)
        
        viewModel.fullName.subscribe(fn).disposed(by: disposeBag)
        viewModel.average.subscribe(fn).disposed(by: disposeBag)
        viewModel.studentID.subscribe(fn).disposed(by: disposeBag)
        viewModel.textFieldText.subscribe(fn).disposed(by: disposeBag)
        viewModel.grades.subscribe(fn).disposed(by: disposeBag)
        try? viewModel.addGrade(text: "20")
        try? viewModel.addGrade(text: "-10")
        try? viewModel.addGrade(text: "1000")
        try? viewModel.addGrade(text: "abc")
        
        scheduler.start()
        
        _ = StudentViewModel()
    }
    
}
