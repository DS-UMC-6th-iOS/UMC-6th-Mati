//
//  FeedUploadModel.swift
//  CatStaGram
//
//  Created by 김미주 on 28/06/2024.
//

struct FeedUploadModel: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: FeedUploadResult
}

struct FeedUploadResult: Decodable {
    var postIdx: Int
}
