//
//  RegisterViewController.swift
//  CatStaGram
//
//  Created by 김미주 on 02/05/2024.
//

import UIKit

class RegisterViewController: UIViewController {
    // MARK: - Properties
    var email: String = ""
    var name: String = ""
    var nickname: String = ""
    var password: String = ""
    
    var userInfo: ((UserInfo) -> Void)?
    
    // 유효성 검사를 위한 프로퍼티
    var isValidEmail = false {
        didSet { // 프로퍼티 옵저버 (세팅 후에 코드 블록 실행)
            self.validateUserInfo()
        }
    }
    
    var isValidName = false {
        didSet { // 프로퍼티 옵저버 (세팅 후에 코드 블록 실행)
            self.validateUserInfo()
        }
    }
    
    var isValidNikname = false {
        didSet { // 프로퍼티 옵저버 (세팅 후에 코드 블록 실행)
            self.validateUserInfo()
        }
    }
    
    var isValidPassword = false {
        didSet { // 프로퍼티 옵저버 (세팅 후에 코드 블록 실행)
            self.validateUserInfo()
        }
    }

    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var popToLoginButton: UIButton!
    
    // Textfields
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var nicknameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var textFields: [UITextField] { // 배열
        [emailTextField, nameTextField, nicknameTextField, passwordTextField]
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupAttribute()
        
        // bug fix
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
//        signupButton.layer.cornerRadius = 5
    }
    
    
    // MARK: - Actions
    @objc
    func textFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        
        switch sender {
        case emailTextField:
            self.isValidEmail = text.isValidEmail()
            self.email = text

        case nameTextField:
            self.isValidName = text.count > 2
            self.name = text
            
        case nicknameTextField:
            self.isValidNikname = text.count > 2
            self.nickname = text
            
        case passwordTextField:
            self.isValidPassword = text.isValidPassword()
            self.password = text
            
        default:
            fatalError("Missing TextField...")
        }
        
    }
    
    @IBAction func backButtonDidTap(_ sender: UIBarButtonItem) {
        // 뒤로가기
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        // 뒤로가기
        self.navigationController?.popViewController(animated: true)
        
        let userInfo = UserInfo (email: self.email, name: self.name, nickname: self.nickname, password: self.password)
        
        self.userInfo?(userInfo)
    }
    
    
    
    // MARK: - Helpers
    // textfield와 action을 연결
    private func setupTextField() {
        
        textFields.forEach { tf in
            tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        }
//        emailTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
//        nameTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
//        nicknameTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
//        passwordTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    }
    
    // 사용자가 입력한 회원정보를 확인하고 UI 업데이트
    private func validateUserInfo() {
        
        if isValidEmail && isValidName && isValidNikname && isValidPassword {
            self.signupButton.isEnabled = true 
            UIView.animate(withDuration: 0.33) {
                self.signupButton.backgroundColor = UIColor(named: "facebookColor")
            }
        } else {
            self.signupButton.isEnabled = false
            UIView.animate(withDuration: 0.33) {
                self.signupButton.backgroundColor = UIColor(named: "disabledButtonColor")
            }
        }
    }
    
    private func setupAttribute() {
        // registerButton
        
        let text1 = "계정이 있으신가요?"
        let text2 = "로그인"
        
        let font1 = UIFont.systemFont(ofSize: 13)
        let font2 = UIFont.boldSystemFont(ofSize: 13)
        
        let color1 = UIColor.darkGray
        let color2 = UIColor.facebookColor
        
        let attributes = generateButtonAttribute(self.popToLoginButton, texts: text1, text2, fonts: font1, font2, colors: color1, color2)
        
        self.popToLoginButton.setAttributedTitle(attributes, for: .normal)
    }
    
}

// 정규표현식
extension String {
    // 대문자, 소문자, 특수문자, 숫자 8자 이상일 때 true
    func isValidPassword() -> Bool {
        let regularExpression = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[\\d])(?=.*[~!@#\\$%\\^&\\*])[\\w~!@#\\$%\\^&\\*]{8,}$"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
        
        return passwordValidation.evaluate(with: self)
    }
    
    // @ 포함, 2글자 이상 true
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate.init(format: "SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: self)
    }
}
