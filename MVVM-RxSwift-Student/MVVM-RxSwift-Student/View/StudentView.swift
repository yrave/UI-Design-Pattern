//
//  StudentView.swift
//  MVVM-Student
//
//  Created by Yannick Rave on 19.02.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class StudentView: UIView {
    private let disposeBag = DisposeBag()
    lazy var viewModel: StudentViewModel = StudentViewModel()
    
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var gradePointAverageLabel: UILabel!
    @IBOutlet var allGradesLabel: UILabel!
    @IBOutlet var studentIDLabel: UILabel!
    @IBOutlet var newGradeTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.fullNameLabel.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        
        self.addButton.addTarget(self, action: #selector(didSelectAddButton), for: .touchUpInside)
        
        self.viewModel.fullName.bind(to: self.fullNameLabel.rx.text).disposed(by: disposeBag)
        self.viewModel.grades.bind(to: self.allGradesLabel.rx.text).disposed(by: disposeBag)
        self.viewModel.studentID.bind(to: self.studentIDLabel.rx.text).disposed(by: disposeBag)
        self.viewModel.textFieldText.bind(to: self.newGradeTextField.rx.text).disposed(by: disposeBag)
        self.viewModel.average.bind(to: self.gradePointAverageLabel.rx.text).disposed(by: disposeBag)
    }
    
    @objc func didSelectAddButton() {
        do {
            try self.viewModel.addGrade(text: self.newGradeTextField.text)
        } catch { } //TODO: Show error
    }
}
