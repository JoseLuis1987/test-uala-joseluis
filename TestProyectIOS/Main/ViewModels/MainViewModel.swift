//
//  MainViewModel.swift
//  TestProyectIOS
//
//  Created by Jose Luis on 25/12/20.
//  Copyright © 2020 Jose Luis. All rights reserved.
//

import Foundation

struct MainViewViewModel {
    weak var  dataSource : GenericDataSource<Meal>? = GenericDataSource<Meal>?(nil)
    var mealsResponse : Dynamic<Meals?> = Dynamic<Meals?>(nil)
    weak var service: MealServices?
    var onErrorHandling : ((ErrorResult?) -> Void)?
    
    init(dataSource : GenericDataSource<Meal>?, serviceMeal: MealServicesProtocol = MealServices.shared) {
        self.dataSource = dataSource
        self.service = (serviceMeal as! MealServices)
        
    }
    func fertchMeals(strToSearch:String){
        guard let serviceGetMeals = service else {
            onErrorHandling?(ErrorResult.custom(string: "Missing service"))
            return
        }
        serviceGetMeals.getMeals(str: strToSearch) { (result) in
            switch result{
            case .success(let response):
                self.mealsResponse.value = response
                self.dataSource?.data.value = response.meals ?? []
            case .failure(let error):
                self.onErrorHandling?(.custom(string: String(format: "%@", (error.get()))))
            }
        }
    }
}
