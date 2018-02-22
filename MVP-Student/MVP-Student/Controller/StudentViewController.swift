//
//  StudentViewController.swift
//  MVC-Student
//
//  Created by Yannick Rave on 19.02.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import UIKit

class StudentViewController: UIViewController {
    
    @IBOutlet var studentView: StudentView!
    var studentPresenter: StudentPresenter!
    
    private let student = Student(
        firstName: "John", lastName: "Doe",
        grades: [50, 50, 100, 60, 85], studentID: 123456)


    override func viewDidLoad() {
        super.viewDidLoad()
        
        studentPresenter = StudentPresenter(studentView: self.studentView, student: student)
        studentPresenter.startSetup()
    }
}
