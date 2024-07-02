//
//  SignUpViewController.swift
//  LoginProject
//
//  Created by 김미주 on 28/06/2024.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class SignUpViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var textUsername: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var textPasswordCheck: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    
    // 유효성 검사
    let emailPattern = "^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\\.[a-zA-Z]{2,3}$"
    let passwordPattern = "^.*(?=^.{8,16}$)(?=.*\\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$"
    
    // valid
    var emailValid = false
    var passwordValid = false
    var allValid = false
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()

        btnSignUp.layer.cornerRadius = 5
    }
    
    // MARK: - function
    func addTarget() {
        textEmail.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textPasswordCheck.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    func isValid(text: String, pattern: String) -> Bool {
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: text)
    }
    
    func checkEmail() {
        print(textEmail.text!)
        if isValid(text: textEmail.text!, pattern: emailPattern) {
            print("Email Success")
            emailValid = true
        } else {
            print("Email Fail")
            emailValid = false
        }
    }
    
    func checkPassword() {
        print(textPassword.text!)
        if isValid(text: textPasswordCheck.text!, pattern: passwordPattern) {
            if (textPasswordCheck.text == textPassword.text) {
                print("Password Success")
                passwordValid = true
            } else {
                print("Password Fail")
                passwordValid = false
            }
        } else {
            print("Password Fail")
            passwordValid = false
        }
    }
    
    func checkAll() {
        if emailValid && passwordValid {
            print("Email, Password Valid Success")
            allValid = true
        } else {
            print("Email, Password Valid Fail")
            allValid = false
        }
    }
    
    func createUser() {
        print("createUser")
        guard let email = textEmail.text else { return }
        guard let password = textPasswordCheck.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error)
            }
            if let result = result {
                print(result)
            }
        }
    }
    
    // 빈 화면 클릭하면 키보드 내려가게
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
        }
    
    // MARK: - Action
    @objc func textFieldDidChange(_ sender: UITextField) -> Bool {
        switch sender {
        case textEmail:
            checkEmail()
        case textPasswordCheck:
            checkPassword()
        default:
            break
        }
        checkAll()
        return true
    }
    
    
    @IBAction func clickSignUpBtn(_ sender: Any) {
        print("회원가입 버튼 클릭")
        
        if let name = textUsername.text {
            print("Name: ", name)
        }
        if let email = textEmail.text {
            print("Email: ", email)
        }
        if let password = textPasswordCheck.text {
            print("Password: ", password)
        }
        if allValid {
            createUser()
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func clickBackBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
