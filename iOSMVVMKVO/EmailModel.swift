//
//  EmailModel.swift
//  iOSMVVMKVO
//
//  Created by Alfian Losari on 03/06/18.
//  Copyright © 2018 Alfian Losari. All rights reserved.
//

import Foundation

class EmailModel {
    
    static let valueDidChange = Notification.Name("valueDidChange")
    static let isValidDidChange = Notification.Name("isValidDidChange")
    static private let regexEmail = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
    
    init(value: String) {
        self.value = value
    }

    var value: String = "" {
        willSet {
            NotificationCenter.default.post(name: EmailModel.valueDidChange, object: self, userInfo: [\EmailModel.value: newValue])
            self.isValid = validateEmail(newValue)
        }
    }
    
    public private(set) var isValid: Bool = false {
        willSet {
            NotificationCenter.default.post(name: EmailModel.isValidDidChange, object: self, userInfo: [\EmailModel.isValid: newValue])
        }
    }
    
    private func validateEmail(_ email: String) -> Bool {
        guard !email.isEmpty else { return false }
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@",  EmailModel.regexEmail)
        let emailEvaluate = emailPredicate.evaluate(with: email)
        guard emailEvaluate else { return false }
        return true
    }
    
}
