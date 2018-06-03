//
//  EmailViewModel.swift
//  iOSMVVMKVO
//
//  Created by Alfian Losari on 03/06/18.
//  Copyright © 2018 Alfian Losari. All rights reserved.
//

import Foundation

class EmailViewModel: NSObject {
    
    private let emailModel: EmailModel
    @objc dynamic var emailTextValue: String
    @objc dynamic var isValidValue: Bool
    
    private var emailTextObserver: NSObjectProtocol?
    private var isValidObserver: NSObjectProtocol?
    
    init(emailModel: EmailModel) {
        self.emailModel = emailModel
        self.emailTextValue = emailModel.value
        self.isValidValue = emailModel.isValid
        super.init()
        self.emailTextObserver = NotificationCenter.default.addObserver(forName: EmailModel.valueDidChange, object: nil, queue: nil, using: { [weak self] (note) in
            self?.emailTextValue = note.userInfo?[\EmailModel.value] as? String ?? ""
        })
        
        self.isValidObserver = NotificationCenter.default.addObserver(forName: EmailModel.isValidDidChange, object: nil, queue: nil, using: { [weak self] (note) in
            self?.isValidValue = note.userInfo?[\EmailModel.isValid] as? Bool ?? false
        })
    }
    
    public func updateEmailTextValue(_ value: String) {
        self.emailModel.value = value
    }
    
    deinit {
        if let emailTextObserver = emailTextObserver {
            NotificationCenter.default.removeObserver(emailTextObserver, name: EmailModel.valueDidChange, object: nil)
        }
        
        if let isValidObserver = isValidObserver {
            NotificationCenter.default.removeObserver(isValidObserver, name: EmailModel.isValidDidChange, object: nil)
        }
    }
    
}
