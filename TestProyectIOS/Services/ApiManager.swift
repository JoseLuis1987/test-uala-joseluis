//
//  ApiManager.swift
//  TestProyectIOS
//
//  Created by Jose Luis on 25/12/20.
//  Copyright © 2020 Jose Luis. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

public typealias JsonObject = [String: Any]
public typealias JsonArray = [[String: Any]]

class APIManager {
    static let sharedInstance = APIManager()
    func request(urlRequest: URLRequest, completion: @escaping (_ success: Bool , _ fail: String, _ data: Data, _ errorCode:Int ) -> ()) {
        var request = urlRequest
        request.timeoutInterval = Constants.timeOut
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            var codeError = -1
              if let code = response?.getStatusCode(){
                    codeError = code
                }
            if(error != nil){
                completion(false, error!.localizedDescription, Data.init(), codeError)
            } else{
                print(response?.getStatusCode())
                var dataString = String(data: data!, encoding: String.Encoding.utf8)
                print(dataString)
                if response?.getStatusCode() == 200{
                    completion(true, "Exitoso".localized, data!, codeError)
                 }else {
                    completion(false, error!.localizedDescription, Data.init(), codeError)
                }
            }
        })
        task.resume()
    }
}

