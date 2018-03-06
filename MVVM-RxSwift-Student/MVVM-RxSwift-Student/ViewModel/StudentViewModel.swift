//
//  StudentViewModel.swift
//  MVVM-Student
//
//  Created by Yannick Rave on 19.02.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import Foundation
import RxSwift

class StudentViewModel {
    private let disposeBag = DisposeBag()
    
    private let studentSubject: Variable<Student>
    lazy var fullName: Observable<String> = self.studentSubject.asObservable()
        .map({ "\($0.firstName) \($0.lastName)" })
    lazy var grades: Observable<String> = self.studentSubject.asObservable()
        .map({ $0.grades.map({ "\($0)" }).joined(separator: ", ") })
    lazy var studentID: Observable<String> = self.studentSubject.asObservable()
        .map({ "\($0.studentID)" })
    lazy var average: Observable<String> = self.studentSubject.asObservable()
        .map({ "\($0.average)" })
    lazy var textFieldText = BehaviorSubject<String>(value: "")

    init(student: Student? = nil) {
        let student = student ?? Student(
            firstName: "John", lastName: "Doe",
            grades: [50, 50, 100, 60, 85], studentID: 123456)

        self.studentSubject = Variable(student)

        self.studentSubject.asObservable()
            .subscribe(onNext: { [unowned self] student in
                student.delegate = self
            }).disposed(by: disposeBag)

    }

    enum GradeError: Error {
        case invalidInput
    }

    func addGrade(text: String?) throws {
        guard let grade = text.flatMap({ Int($0) }) else { throw GradeError.invalidInput }
        try studentSubject.value.add(grade: grade)
        self.textFieldText.onNext("")
    }
}

extension StudentViewModel: StudentDelegate {
    func didChangeGradeAndAverage() {
        self.studentSubject.value = self.studentSubject.value
    }
}
