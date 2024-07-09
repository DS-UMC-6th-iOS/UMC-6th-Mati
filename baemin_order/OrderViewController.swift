//
//  OrderViewController.swift
//  baemin_order
//
//  Created by 김미주 on 20/05/2024.
//

import UIKit

class OrderViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    struct orderItem {
        var size: String?
        var dough: Bool?
        var price: String?
    }
    
    var data: [orderItem] = []
    var selectedSize: String?
    var sizePrice: String?
    var selectedDough: Bool?
    var selectedPrice: String?
    var calcPrice: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigationBar 없앰
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        tableView.delegate = self
        tableView.dataSource = self
        
        let orderNib = UINib(nibName: "OrderTableViewCell", bundle: nil)
        tableView.register(orderNib, forCellReuseIdentifier: "OrderTableViewCell")
        
        tableView.reloadData()
    }
    
    @IBAction func tapBack(_ sender: Any) {
        // 전 VC로 돌아가기
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as? OrderTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        let item = data[indexPath.row]
        let sizePrice = (item.size == "M") ? "20,000원" : "23,000원"
        cell.labelOptionPrice.text = "• 가격 : \(item.size ?? "") (\(sizePrice))"
        if item.dough == true {
            cell.labelOptionDough.layer.isHidden = false
            cell.labelOptionDough.text = "• 도우변경 : 크림리치골드 크러스트 (4,500원)"
        }
        cell.labelPrice.text = "\(item.price ?? "" )원"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
