//
//  ViewController.swift
//  MVC-Student
//
//  Created by Yannick Rave on 19.02.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var studentView: StudentView!
    var studentPresenter: StudentPresenter!
    
    private let student = Student(
        firstName: "John", lastName: "Doe",
        grades: [50, 50, 100, 60, 85], studentID: 123456)


    override func viewDidLoad() {
        super.viewDidLoad()
        
        studentPresenter = StudentPresenter(studentView: self.studentView, student: student)
        studentPresenter.startSetup()
        studentView.newGradeTextField.delegate = self
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        do {
            try studentPresenter.addGrade(text: textField.text)
        } catch { } //TODO: Show error
        return true
    }
}
