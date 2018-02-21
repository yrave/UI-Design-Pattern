//
//  StudentViewController.swift
//  MVVM-Student
//
//  Created by Yannick Rave on 19.02.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import UIKit

class StudentViewController: UIViewController {
    
    @IBOutlet var studentView: StudentView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.studentView.newGradeTextField.delegate = self
    }
}


extension StudentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        do {
            try self.studentView.textFieldChanged(textField.text)
        } catch { } //TODO: Show error
        return true
    }
}

