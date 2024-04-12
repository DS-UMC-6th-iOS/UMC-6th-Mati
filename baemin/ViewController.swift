//
//  ViewController.swift
//  baemin
//
//  Created by 김미주 on 10/04/2024.
//
import UIKit

class ViewController: UIViewController {

    @IBOutlet var topView: UIView!
    @IBOutlet var bottomView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var shopLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 하단 모서리 둥글게
        topView.layer.cornerRadius = 20
        topView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        
        // 상단 모서리 둥글게
        bottomView.layer.cornerRadius = 20
        bottomView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMinXMinYCorner)
        
    }
    
    
}
