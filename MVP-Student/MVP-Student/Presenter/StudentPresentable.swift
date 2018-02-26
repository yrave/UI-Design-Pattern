//
//  StudentPresentable.swift
//  MVP-Student
//
//  Created by Yannick Rave on 19.02.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import Foundation

protocol StudentPresentableView: class {
    func setFullNameText(_ value: String)
    func setGradePointAverageText(_ value: String)
    func setAllGradesText(_ value: String)
    func setStudentIDText(_ value: String)
    var newGradeTextFieldText: String? { get set }
    weak var delegate: StudentViewDelegate? { get set }
}
