//
//  OrderTableViewCell.swift
//  baemin_order
//
//  Created by 김미주 on 19/05/2024.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    @IBOutlet weak var labelOrder: UILabel!
    @IBOutlet weak var labelOptionPrice: UILabel!
    @IBOutlet weak var labelOptionDough: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var imgOrder: UIImageView!
    @IBOutlet weak var btnOption: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    var deleteAction: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgOrder.layer.cornerRadius = 10
        btnOption.layer.cornerRadius = 5
        btnOption.layer.borderWidth = 1
        btnOption.layer.borderColor = UIColor.lightGray.cgColor
        
        labelOptionDough.layer.isHidden = true
        
        btnDelete.addTarget(self, action: #selector(btnDeleteTapped), for: .touchUpInside)
    }
    
    @IBAction func btnDeleteTapped(_ sender: Any) {
        deleteAction?()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
