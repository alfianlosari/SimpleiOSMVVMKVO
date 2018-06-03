//
//  ViewController.swift
//  iOSMVVMKVO
//
//  Created by Alfian Losari on 03/06/18.
//  Copyright © 2018 Alfian Losari. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailValidationLabel: UILabel!
    let emailViewModel = EmailViewModel(emailModel: EmailModel(value: ""))
    var emailTextObserver: NSObjectProtocol?
    var isValidEmailObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewModel()
    }
    
    func observeViewModel() {
        self.emailTextObserver = emailViewModel.observe(\EmailViewModel.emailTextValue, options: [.initial, .new], changeHandler: { [weak self] (_, change) in
            self?.emailTextField.text = change.newValue
        })
        
        self.isValidEmailObserver = emailViewModel.observe(\EmailViewModel.isValidValue, options: [.initial, .new], changeHandler: { [weak self] (_, change) in
            guard let strongSelf = self else { return }
            let isValid = change.newValue ?? false
            self?.emailValidationLabel.text = isValid ? "Email is valid" : "Email is invalid"
            self?.emailValidationLabel.textColor = isValid ? strongSelf.view.tintColor : .red
        })
        
        self.emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        self.emailViewModel.updateEmailTextValue(self.emailTextField.text ?? "")
    }
    
}

