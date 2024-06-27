//
//  PostCollectionViewCell.swift
//  CatStaGram
//
//  Created by 김미주 on 24/05/2024.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostCollectionViewCell"

    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // 이미지를 외부에서 가져오기 위해 public으로 설정
    public func setupData() {
        // 이미지뷰의 이미지를 업로드한다.
    }

}
