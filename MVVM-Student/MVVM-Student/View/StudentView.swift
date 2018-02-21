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
    lazy var viewModel: StudentViewModel = {
        let vm = StudentViewModel()
        vm.updateGradeInputText = { [weak self] in self?.newGradeTextField.text = $0 }
        vm.observeGradeAverage = { [weak self] in self?.gradePointAverageLabel.text = $0 }
        vm.observeGrades = { [weak self] in self?.allGradesLabel.text = $0 }
        return vm
    }()
    
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
    }
    
    func textFieldChanged(_ text: String?) throws {
        try self.viewModel.addGrade(text: text)
    }
}


