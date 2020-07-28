//
//  Result.swift
//  Pomelo
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//

import SwiftyJSON

struct Result<T> {
    let status: ResultStatus
    let code: String
    let data: T?
    let error: String?
    let message: String?
    
    enum ResultStatus {
        case success
        case fail
    }
    
    static func fail(json: JSON) -> Result<T> {
        let result = Result<T>(
            status: .fail,
            code: json["code"].string ?? Strings.commonErrorCode,
            data: nil,
            error: json["error"].string ?? Strings.commonError,
            message: json["message"].string ?? "")
        
        return result
    }
    
    static func success(data: T) -> Result<T> {
        let result = Result<T>(
            status: .success,
            code: "200",
            data: data,
            error: nil,
            message: nil)
        
        return result
    }
}
