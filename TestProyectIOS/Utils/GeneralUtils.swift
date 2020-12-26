//
//  GeneralUtils.swift
//  TestProyectIOS
//
//  Created by Jose Luis on 25/12/20.
//  Copyright © 2020 Jose Luis. All rights reserved.
//

import Foundation


enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
     func get() -> String {
        switch self {
        case .network(let red):
            return red
        case .parser(let par):
            return par
        case .custom(let custo):
            return custo
        }
    }
}
enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}
class Dynamic<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}

typealias CompletionHandler = (() -> Void)
class DynamicValue<T> {
    
    var value : T {
        didSet {
            self.notify()
        }
    }
    
    private var observers = [String: CompletionHandler]()
    
    init(_ value: T) {
        self.value = value
    }
    
    public func addObserver(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        observers[observer.description] = completionHandler
    }
    
    public func addAndNotify(observer: NSObject, completionHandler: @escaping CompletionHandler) {
        self.addObserver(observer, completionHandler: completionHandler)
        self.notify()
    }
    
    private func notify() {
        observers.forEach({ $0.value() })
    }
    
    deinit {
        observers.removeAll()
    }
}

extension URLResponse {
    
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
extension URLSession {
    func synchronousDataTask(urlrequest: URLRequest) -> (data: Data?, response: URLResponse?, error: Error?) {
        var data: Data?
        var response: URLResponse?
        var error: Error?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let dataTask = self.dataTask(with: urlrequest) {
            data = $0
            response = $1
            error = $2
            
            semaphore.signal()
        }
        dataTask.resume()
        
        _ = semaphore.wait(timeout: .now() + .seconds(2))
        
        return (data, response, error)
    }
}
extension Data
{
    func toString() -> String
    {
        return String(data: self, encoding: .utf8)!
    }
}
extension NSMutableData
{
    func toString() -> String
    {
        return String(data: self as Data, encoding: .utf8)!
    }
}
extension String {
    func isEqualToString(find: String) -> Bool {
        return String(format: self) == find
    }
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
