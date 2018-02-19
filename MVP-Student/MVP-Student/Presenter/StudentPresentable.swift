//
//  StudentPresentable.swift
//  MVP-Student
//
//  Created by Yannick Rave on 19.02.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import Foundation
import UIKit

protocol StudentPresentableView: class {
    var fullNameLabel: UILabel! { get }
    var gradePointAverageLabel: UILabel! { get }
    var allGradesLabel: UILabel! { get }
    var studentIDLabel: UILabel! { get }
    var newGradeTextField: UITextField! { get }
}

protocol StudentPresentable: class {
    var studentPresentableView: StudentPresentableView { get }
    func showError()
}
