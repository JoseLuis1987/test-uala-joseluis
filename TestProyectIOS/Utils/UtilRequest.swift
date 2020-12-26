//
//  UtilRequest.swift
//  TestProyectIOS
//
//  Created by Jose Luis on 25/12/20.
//  Copyright © 2020 Jose Luis. All rights reserved.
//

import Foundation

import Foundation
open class UtilRequest {
    func creaRequesBase(contextToUrl:String, bodyRequest: [String: Any], operacion:String, params:[String:Any]? = nil, origen:String? = nil , method: String) -> URLRequest {
        do {
            let urlString:String = "\(ConfigRed.rutaWS)/\(contextToUrl)"
             print(" URL --> \(urlString)")
            var requestDictionary : NSMutableDictionary!
            requestDictionary = NSMutableDictionary(dictionary: ["":""])
            requestDictionary.addEntries(from: bodyRequest)
            let jsonData = try JSONSerialization.data(withJSONObject: requestDictionary as Any)
            let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
            var request = URLRequest(url: URL(string: urlString)!)
            request.httpMethod = method
            /*
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue("Keep-Alive", forHTTPHeaderField: "Connection")
            request.setValue("gzip,deflate", forHTTPHeaderField: "Accept-Encoding")
            request.setValue(String(jsonData.toString().dropLast().count ), forHTTPHeaderField: "Content-Length")
            request.httpBody = jsonData
            */
            return request
        } catch {
            print("JSON serialization failed: ", error)
        }
        return URLRequest.init(url: URL.init(string: "")!)
    }
}
