//
//  ListViewController.swift
//  WeatherProject
//
//  Created by 김미주 on 09/07/2024.
//

import UIKit

class ListViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var tabelView: UITableView!
    
    let data = ["1", "2", "3"]
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabelView.delegate = self
        tabelView.dataSource = self
        
        let listNib = UINib(nibName: "ListTableViewCell", bundle: nil)
        tabelView.register(listNib, forCellReuseIdentifier: "ListTableViewCell")
        
        tabelView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click")
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
        detailVC.modalTransitionStyle = .coverVertical
        self.present(detailVC, animated: true, completion: nil)
    }

}
