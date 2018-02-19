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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.studentView.newGradeTextField.delegate = self
    }
}


extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        do {
            try self.studentView.viewModel.addGrade(text: textField.text)
        } catch { } //TODO: Show error
        return true
    }
}

