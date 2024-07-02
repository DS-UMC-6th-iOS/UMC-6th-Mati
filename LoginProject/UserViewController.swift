//
//  UserViewController.swift
//  LoginProject
//
//  Created by 김미주 on 01/07/2024.
//

import UIKit

class UserViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var userNmae: UILabel!
    var name: String?
        
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        if let name = name {
            self.userNmae.text = name + "님"
        }
    }
    
}
