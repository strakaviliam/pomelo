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
    let error: ResultError?
    
    enum ResultStatus {
        case success
        case fail
    }
    
    static func fail(json: JSON) -> Result<T> {
        let result = Result<T>(
            status: .fail,
            code: json["code"].string ?? Strings.commonErrorCode,
            data: nil,
            error: ResultError(error: json["error"].string ?? Strings.commonError, message: json["message"].string ?? ""))
        
        return result
    }
    
    static func success(data: T) -> Result<T> {
        let result = Result<T>(
            status: .success,
            code: "200",
            data: data,
            error: nil)
        
        return result
    }
}

struct ResultError {
    let error: String?
    let message: String?
    
    static func defaultError() -> ResultError {
        let error = ResultError(
            error: Strings.commonError,
            message: "")
        
        return error
    }
}
