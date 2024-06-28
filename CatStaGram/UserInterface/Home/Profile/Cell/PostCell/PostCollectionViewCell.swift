//
//  PostCollectionViewCell.swift
//  CatStaGram
//
//  Created by 김미주 on 24/05/2024.
//

import UIKit
import Kingfisher

class PostCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostCollectionViewCell"

    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // 이미지를 외부에서 가져오기 위해 public으로 설정
    public func setupData(_ imageURLStr: String?) {
        // 이미지뷰의 이미지를 업로드한다.
        
        guard let imageURLStr = imageURLStr else { return }
        if let url = URL(string: imageURLStr) {
            postImageView.kf.setImage(
                with: url,
                placeholder: UIImage(systemName: "photo"))
        }
    }

}
