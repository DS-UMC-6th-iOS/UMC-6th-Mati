//
//  ViewController.swift
//  Protocol
//
//  Created by 김미주 on 03/05/2024.
//

import UIKit

// 클래스 바깥에서 선언
protocol Flyable {
    func fly()
}

protocol Runable {
    func run()
}

// Flyable 기능 추가
class Person: Flyable, Runable {
    func run() {
        print("달렸.")
    }
    
    func fly() {
        print("날았다.")
    }
}

protocol ChangeLabelDelegate {
    func doChange()
}

class ViewController: UIViewController {
    
    let person = Person()
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func buttonGoNextVC(_ sender: Any) {
        guard let nextVC = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else {
            return
        }
        nextVC.previousViewController = self
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true, completion: nil)
    }
    
    var delegate: ChangeLabelDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        person.fly()
        person.run()
    }


}

