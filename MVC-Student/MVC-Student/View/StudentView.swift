//
//  StudentView.swift
//  MVC-Student
//
//  Created by Yannick Rave on 19.02.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import Foundation
import UIKit

protocol StudentViewDelegate: class {
    func textFieldShouldReturn(text: String?)
}

class StudentView: UIView {
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var gradePointAverageLabel: UILabel!
    @IBOutlet var allGradesLabel: UILabel!
    @IBOutlet var studentIDLabel: UILabel!
    @IBOutlet var newGradeTextField: UITextField!
    
    weak var delegate: StudentViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.fullNameLabel.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        self.newGradeTextField.delegate = self
    }
}

extension StudentView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.textFieldShouldReturn(text: textField.text)
        return true
    }
}
