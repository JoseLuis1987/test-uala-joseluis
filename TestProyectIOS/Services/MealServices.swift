//
//  MealServices.swift
//  TestProyectIOS
//
//  Created by Jose Luis on 25/12/20.
//  Copyright © 2020 Jose Luis. All rights reserved.
//

import Foundation
import ObjectMapper
protocol MealServicesProtocol : class {
    func getMeals(str:String , _ completion: @escaping ((Result<Meals, ErrorResult>) -> Void))
}
final class MealServices : MealServicesProtocol {
    static let shared = MealServices()
    func getMeals(str:String, _ completion: @escaping ((Result<Meals, ErrorResult>) -> Void)) {
        APIManager().request(urlRequest: UtilRequest().creaRequesBase(contextToUrl:
            "search.php?s=\(str)", bodyRequest: ["":""], operacion: "", method: "GET")){ (success, fail , data, codeError) in
                if success{
                    if let strDatos = String(data: data, encoding: String.Encoding.utf8), let responseGetMeals = Mapper<Meals>().map(JSONString: strDatos){
                        if responseGetMeals.meals != nil{
                            completion(.success(responseGetMeals))
                        }else if responseGetMeals.meals?.count == nil{
                            completion(.failure(.custom(string: "No se pudo obtener información ")))
                        }else{
                            completion(.failure(.custom(string: "Error al mappear los datos")))
                        }
                    }else{
                        completion(.failure(.custom(string: Constants.msjGenericoMasTarde)))
                    }
                }else{
                    print("fail response consulta WS\(fail)")
                    completion(.failure(.network(string: fail)))
                }
        }
    }
    func getMeals(id:Int, _ completion: @escaping ((Result<Meals, ErrorResult>) -> Void)) {
        APIManager().request(urlRequest: UtilRequest().creaRequesBase(contextToUrl:
            "lookup.php?i=\(id)", bodyRequest: ["":""], operacion: "", method: "GET")){ (success, fail , data, codeError) in
                if success{
                    if let strDatos = String(data: data, encoding: String.Encoding.utf8), let responseGetMeals = Mapper<Meals>().map(JSONString: strDatos){
                        if responseGetMeals.meals != nil{
                            completion(.success(responseGetMeals))
                        }else if responseGetMeals.meals?.count == nil{
                            completion(.failure(.custom(string: "No se pudo obtener información ")))
                        }else{
                            completion(.failure(.custom(string: "Error al mappear los datos")))
                        }
                    }else{
                        completion(.failure(.custom(string: Constants.msjGenericoMasTarde)))
                    }
                }else{
                    print("fail response consulta WS\(fail)")
                    completion(.failure(.network(string: fail)))
                }
        }
    }
}
