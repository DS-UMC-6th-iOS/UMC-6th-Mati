//
//  ViewController.swift
//  baemin_order
//
//  Created by 김미주 on 10/05/2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var btnMsize: UIButton!
    @IBOutlet weak var btnLsize: UIButton!
    @IBOutlet weak var btnCream: UIButton!
    @IBOutlet weak var btnOrder: UIButton!
    
    @IBAction func actionMsize(_ sender: Any) {
        btnMsize.isSelected = true
        btnLsize.isSelected = false
    }
    @IBAction func actionLsize(_ sender: Any) {
        btnLsize.isSelected = true
        btnMsize.isSelected = false
    }
    
    @IBAction func actionCream(_ sender: Any) {
        if btnCream.isSelected {
            btnCream.isSelected = false
        } else {
            btnCream.isSelected = true
        }
    }
    
    @IBAction func actionOrder(_ sender: Any) {
        guard let orderVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderViewController") else { return }
        self.navigationController?.pushViewController(orderVC, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }


}


