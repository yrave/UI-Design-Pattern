//
//  StudentView.swift
//  MVVM-Student
//
//  Created by Yannick Rave on 19.02.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import Foundation
import UIKit

class StudentView: UIView {
    lazy var viewModel: StudentViewModel = StudentViewModel()
    
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var gradePointAverageLabel: UILabel!
    @IBOutlet var allGradesLabel: UILabel!
    @IBOutlet var studentIDLabel: UILabel!
    @IBOutlet var newGradeTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.fullNameLabel.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        
        self.fullNameLabel.text = viewModel.fullName
        self.studentIDLabel.text = viewModel.studentID
        self.newGradeTextField.delegate = self
        
        viewModel.delegate = self
    }
}

extension StudentView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        do {
            try self.viewModel.addGrade(text: textField.text)
        } catch { } //TODO: Show error
        return true
    }
}

extension StudentView: StudentViewModelDelegate {
    func updateGradeInputText(text: String) {
        self.newGradeTextField.text = text
    }
    
    func observeGradeAverage(text: String) {
        self.gradePointAverageLabel.text = text
    }
    
    func callObserveGrades(text: String) {
        self.allGradesLabel.text = text
    }
}
