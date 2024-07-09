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
        let name: String
        let option: String
        let price: String
    }
    
    var data: [orderItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigationBar 없앰
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        tableView.delegate = self
        tableView.dataSource = self
        
        let orderNib = UINib(nibName: "OrderTableViewCell", bundle: nil)
        tableView.register(orderNib, forCellReuseIdentifier: "OrderTableViewCell")
        
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
