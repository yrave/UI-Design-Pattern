//
//  StudentViewModelRx.swift
//  MVVM-RxSwift-Student
//
//  Created by Yannick Rave on 19.03.18.
//  Copyright © 2018 Yannick Rave. All rights reserved.
//

import Foundation
import RxSwift

enum Result<T> {
    case error(Error), value(T)
}

class StudentViewModelRx {
    private let disposeBag = DisposeBag()
    
    private let studentSubject: BehaviorSubject<Student>
    private let _newGrade = PublishSubject<Int>()
    private let _addedGrade = PublishSubject<Void>()
    let _gradesError: Observable<Error?>

    lazy var fullName: Observable<String> = self.studentSubject.asObservable()
        .map({ "\($0.firstName) \($0.lastName)" })
    lazy var studentID: Observable<String> = self.studentSubject.asObservable()
        .map({ "\($0.studentID)" })
    
    private lazy var _grades: Observable<Student> = Observable.merge(
        self._addedGrade.flatMap({ [unowned self] _ in
            self.studentSubject
        }),
        self.studentSubject)
    
    lazy var grades: Observable<String> = self._grades
        .map({ $0.grades.map({ "\($0)" }).joined(separator: ", ") })
    lazy var average: Observable<String> = self._grades
        .map({ "\($0.average)" })
    
    lazy var textFieldText = BehaviorSubject<String>(value: "")
    
    init(student: Student? = nil) {
        let student = student ?? Student(
            firstName: "John", lastName: "Doe",
            grades: [50, 50, 100, 60, 85], studentID: 123456)
        
        self.studentSubject = BehaviorSubject(value: student)
        
        let studentGrade = Observable.combineLatest(self.studentSubject, self._newGrade, resultSelector: { ($0, $1) })
        self._gradesError = studentGrade.map({ (student, newGrade) -> Error? in
            do {
                try student.add(grade: newGrade)
                return nil
            } catch {
                return error
            }
        }).share()

        self._gradesError.subscribe().disposed(by: disposeBag)
        student.delegate = self
        self._grades.map({ _ in "" }).bind(to: self.textFieldText).disposed(by: self.disposeBag)
    }
    
    enum GradeError: Error {
        case invalidInput
    }
    
    func addGrade(text: String?) throws {
        guard let grade = text.flatMap({ Int($0) }) else { throw GradeError.invalidInput }
        self._newGrade.onNext(grade)
    }
}

extension StudentViewModelRx: StudentDelegate {
    func didChangeGradeAndAverage() {
        self._addedGrade.onNext(())
    }
}
