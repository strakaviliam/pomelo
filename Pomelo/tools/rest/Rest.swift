//
//  Rest.swift
//  Pomelo
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//

import Alamofire
import SwiftyJSON

class Rest {
    
    private var manager: SessionManager!
    let printInfo: Bool = true
    
    private var endpoint: String = ""
    private var method: HTTPMethod = .get
    
    private let headersCommon: [String:String] = [
        "Content-Type": "application/json"
    ]
    
    public init(endpoint: String, method: HTTPMethod = .get) {
        self.endpoint = endpoint
        self.method = method
        self.createSessionManager()
    }
    
    private func createSessionManager() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60 // seconds
        configuration.timeoutIntervalForResource = 60
        self.manager = SessionManager(configuration: configuration)
    }
    
    public func call(parameters: [String:Any] = [:], headersAdditional: [String:String]? = nil, fail: @escaping (_ error: JSON) -> Void, success: @escaping (_ data: JSON) -> Void) {
        networkOperation(method: self.method, parameters: parameters, headersAdditional: headersAdditional, fail: fail, success: success)
    }
    
    private func networkOperation(method useMethod: HTTPMethod, parameters: [String:Any], headersAdditional: [String:String]?, fail: @escaping (_ error: JSON) -> Void, success: @escaping (_ data: JSON) -> Void) {
            
        var headers = headersCommon
            
        if headersAdditional != nil {
            for (k, v) in headersAdditional! {
                headers[k] = v
            }
        }
    
        var url = Strings.apiBaseURL + endpoint
        if endpoint.hasPrefix("http") {
            url = endpoint
        }
        
        var params: [String:Any]?
        
        //replace in url any {...} with parameters
        if !parameters.isEmpty {
            var paramsToAdd: [String:Any] = [:]
            for (key, name) in parameters {
                if url.contains(key) && key.hasPrefix("{") && key.hasSuffix("}") {
                    url = url.replacingOccurrences(of: key, with: "\(name)")
                } else {
                    paramsToAdd[key] = name
                }
            }
            params = paramsToAdd
        }
        
        //if get request, create params in path
        if useMethod == .get, let params = params {
            if params.count > 0 {
                var apiParams = ""
                for (key, name) in params {
                    apiParams = apiParams + key + "=" + "\(name)" + "&"
                }
                if apiParams.hasSuffix("&") {
                    apiParams = String(apiParams.dropLast())
                }
                url = "\(url)?\(apiParams)"
            }
        }
        
        if url.hasSuffix("/") {
            url = String(url.dropLast())
        }
        
        if printInfo {
            print("________________________________________________________")
            print("url:   \(url)")
            print("method:   \(useMethod.rawValue)")
            print("headers:   \(headers)")
            print("params:   \(String(describing: params))")
        }
        
        guard let urlEncoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            self.handleFailResponse(response: nil, data: nil, done: { (json) in
                fail(json)
            })
            return
        }
        
        let encoding: ParameterEncoding = useMethod == .post ? JSONEncoding.default : URLEncoding.default
        self.manager.request(urlEncoded, method: useMethod, parameters: params, encoding: encoding, headers: headers).responseJSON { (response) in
            
            if response.result.isSuccess, let responseJSON = response.result.value, let statusCode = response.response?.statusCode {
                if 200...299 ~= statusCode {
                    self.handleSuccessResponse(response: response.response, data: responseJSON, done: { (json) in
                        success(json)
                    })
                } else {
                    self.handleFailResponse(response: response.response, data: response.result.value, done: { (json) in
                        fail(json)
                    })
                }
            } else {
                self.handleFailResponse(response: response.response, data: response.result.value, done: { (json) in
                    fail(json)
                })
            }
        }
    }
        
    private func handleSuccessResponse(response: HTTPURLResponse?, data: Any, done: (_ json: JSON) -> ()) {
        let json: JSON = JSON(data)

        if printInfo {
            print("response:   \(json)")
            
            do {
                if json.type == .null {
                    print("response = empty data")
                } else {
                    let theJSONData = try JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions(rawValue: 0))
                    let theJSONText = NSString(data: theJSONData, encoding: String.Encoding.ascii.rawValue)
                    print("response = \(theJSONText!)")
                }
            } catch _ {}
        }
        
        done(json["body"])
    }
    
    private func handleFailResponse(response: HTTPURLResponse?, data: Any?, done: (_ json: JSON) -> ()) {
        
        var responseDict: [String:Any] = [String:Any]()
        responseDict["code"] = Strings.commonErrorCode
        responseDict["error"] = Strings.commonError
        responseDict["message"] = ""
        
        if (response != nil) {
            responseDict["code"] = "\(response!.statusCode)"
        }
        
        if let data = data {
            let jsonData: JSON = JSON(data)
            
            if jsonData["error"].exists() {
                responseDict["error"] = jsonData["error"].stringValue
            }
            
            if jsonData["message"].exists() {
                responseDict["message"] = jsonData["message"].stringValue
            }
        }
        
        if self.printInfo {
            print("response:   \(responseDict)")
        }
        
        let json = JSON(responseDict)
        
        done(json)
    }
}
