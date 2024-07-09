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
    
    var size: String = "M"
    var dough: Bool = false
    
    var orderData: [OrderViewController.orderItem] = []
    
    @IBAction func actionMsize(_ sender: Any) {
        btnMsize.isSelected = true
        btnLsize.isSelected = false
        size = "M"
    }
    @IBAction func actionLsize(_ sender: Any) {
        btnLsize.isSelected = true
        btnMsize.isSelected = false
        size = "L"
    }
    
    @IBAction func actionCream(_ sender: Any) {
        if btnCream.isSelected {
            btnCream.isSelected = false
            dough = false
        } else {
            btnCream.isSelected = true
            dough = true
        }
    }
    
    @IBAction func actionOrder(_ sender: Any) {
        guard let orderVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderViewController") as? OrderViewController else { return }
        
        // 3자리마다 , 붙이기
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.maximumFractionDigits = 0
        
        let sizePrice = (size == "M") ? "20,000원" : "23,000원"
        var calcPrice = (size == "M") ? 20000 : 23000
        calcPrice += (dough == true) ? 4500 : 0
        let selectedPrice = numberFormatter.string(from: NSNumber(value: calcPrice))
        
        // 새로운 주문 항목을 생성하여 배열에 추가합니다.
        let newItem = OrderViewController.orderItem(size: size, dough: dough, price: selectedPrice)
        orderData.append(newItem)
        
        // 배열을 OrderViewController에 전달합니다.
        orderVC.data = orderData
        
        self.navigationController?.pushViewController(orderVC, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }


}


