//
//  UserFeedDataManager.swift
//  CatStaGram
//
//  Created by 김미주 on 28/06/2024.
//

import Alamofire

class UserFeedDataManager {
    // MARK: 유저 피드 조회 API
    func getUserFeed(_ viewController: ProfileViewController,
                     _ userID: Int = 2) {
        // 통신
        AF.request("https://edu-api-ios-test.softsquared.com/users/\(userID)",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: UserFeedModel.self) { response in
                
            switch response.result {
            case .success(let result):
                viewController.successFeedAPI(result)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
