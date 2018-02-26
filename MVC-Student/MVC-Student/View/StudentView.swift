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
    func didSelectAddButton(text: String?)
}

class StudentView: UIView {
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var gradePointAverageLabel: UILabel!
    @IBOutlet var allGradesLabel: UILabel!
    @IBOutlet var studentIDLabel: UILabel!
    @IBOutlet var newGradeTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    weak var delegate: StudentViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.fullNameLabel.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        self.addButton.addTarget(self, action: #selector(didSelectAddButton), for: .touchUpInside)
    }
    
    @objc func didSelectAddButton() {
        delegate?.didSelectAddButton(text: self.newGradeTextField.text)
    }
}
