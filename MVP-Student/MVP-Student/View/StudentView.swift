//
//  StudentView.swift
//  MVP-Student
//
//  Created by Yannick Rave on 19.02.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import Foundation
import UIKit

class StudentView: UIView, StudentPresentableView {
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var gradePointAverageLabel: UILabel!
    @IBOutlet var allGradesLabel: UILabel!
    @IBOutlet var studentIDLabel: UILabel!
    @IBOutlet var newGradeTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    var presenter: StudentPresenter!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.fullNameLabel.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        self.addButton.addTarget(self, action: #selector(didSelectAddButton), for: .touchUpInside)
    }
    
    var newGradeTextFieldText: String? {
        get {
            return self.newGradeTextField.text
        }
        set {
            self.newGradeTextField.text = newValue
        }
    }

    func setFullNameText(_ value: String) {
        self.fullNameLabel.text = value
    }

    func setGradePointAverageText(_ value: String) {
        self.gradePointAverageLabel.text = value
    }

    func setAllGradesText(_ value: String) {
        self.allGradesLabel.text = value
    }

    func setStudentIDText(_ value: String) {
        self.studentIDLabel.text = value
    }
    
    @objc func didSelectAddButton() {
        presenter.didSelectAddButton(text: self.newGradeTextField.text)
    }
}
