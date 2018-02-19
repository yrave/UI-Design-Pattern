//
//  StudentView.swift
//  MVC-Student
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.fullNameLabel.font = UIFont.systemFont(ofSize: 19, weight: .bold)
    }
}

