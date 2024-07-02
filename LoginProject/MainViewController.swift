//
//  MainViewController.swift
//  LoginProject
//
//  Created by 김미주 on 28/06/2024.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
import FirebaseAuth

class MainViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var errorMsg: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnLogin.layer.cornerRadius = 5
        btnSignUp.layer.cornerRadius = 5

    }
    
    // MARK: - function
    func setUserInfo() {
        UserApi.shared.me {(user, error) in
            if let error = error {
                print(error)
            } else {
                print("이름: \(user?.kakaoAccount?.profile?.nickname ?? "no nickname")")

                guard let userVC = self.storyboard?.instantiateViewController(withIdentifier: "UserViewController") as? UserViewController else { return }
                userVC.modalTransitionStyle = .coverVertical
                userVC.modalPresentationStyle = .fullScreen
                userVC.name = user?.kakaoAccount?.profile?.nickname ?? "no nickname"
                self.present(userVC, animated: true, completion: nil)
            }}
    }
    
    // 빈 화면 클릭하면 키보드 내려가게
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Action
    @IBAction func clickKakaoLogin(_ sender: Any) {
        print("Kakao Login Click.")
        
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    //do something
                    _ = oauthToken
                    
                    self.setUserInfo()
                    
                }
            }
        } else {// 카카오톡 미설치 상태 -> 웹으로 이동해 로그인
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")

                    //do something
                    _ = oauthToken
                    
                    self.setUserInfo()
                }
            }
        }
    }
    
    @IBAction func clickSignUp(_ sender: Any) {
        guard let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
        signUpVC.modalTransitionStyle = .coverVertical
        signUpVC.modalPresentationStyle = .fullScreen
        self.present(signUpVC, animated: true, completion: nil)
    }
    
    @IBAction func clickLogin(_ sender: Any) {
        let email: String = textEmail.text!
        let password: String = textPassword.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if result != nil {
                print("Login Success")
                guard let userVC = self.storyboard?.instantiateViewController(withIdentifier: "UserViewController") as? UserViewController else { return }
                userVC.modalTransitionStyle = .coverVertical
                userVC.modalPresentationStyle = .fullScreen
                userVC.name = email
                self.present(userVC, animated: true, completion: nil)
                
            } else {
                print("Login Fail")
                self.errorMsg.text = "이메일 혹은 비밀번호가 틀렸습니다."
            }
        }
    }
    
    


}
