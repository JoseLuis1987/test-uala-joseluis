//
//  ResulSearchModel.swift
//  TestProyectIOS
//
//  Created by Jose Luis on 25/12/20.
//  Copyright © 2020 Jose Luis. All rights reserved.
//

import Foundation
import ObjectMapper

class Meals: Mappable {
    var meals: [Meal]?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        self.meals <- map["meals"]
    }
}
struct Meal: Mappable {
    var idMeal = ""
    var strArea = ""
    var strCategory = ""
    var strDrinkAlternate = ""
    var strIngredient1 = ""
    var strIngredient2 = ""
    var strIngredient3 = ""
    var strIngredient4 = ""
    var strIngredient5 = ""
    var strIngredient6 = ""
    var strIngredient7 = ""
    var strIngredient8 = ""
    var strIngredient9 = ""
    var strIngredient10 = ""
    var strIngredient11 = ""
    var strIngredient12 = ""
    var strIngredient13 = ""
    var strIngredient14 = ""
    var strIngredient15 = ""
    var strIngredient16 = ""
    var strIngredient17 = ""
    var strIngredient18 = ""
    var strIngredient19 = ""
    var strIngredient20 = ""
    var strMeal = ""
    var strMealThumb = ""
    var strMeasure1 = ""
    var strMeasure2 = ""
    var strMeasure3 = ""
    var strMeasure4 = ""
    var strMeasure5 = ""
    var strMeasure6 = ""
    var strMeasure7 = ""
    var strMeasure8 = ""
    var strMeasure9 = ""
    var strMeasure10 = ""
    var strMeasure11 = ""
    var strMeasure12 = ""
    var strMeasure13 = ""
    var strMeasure14 = ""
    var strMeasure15 = ""
    var strMeasure16 = ""
    var strMeasure17 = ""
    var strMeasure18 = ""
    var strMeasure19 = ""
    var strMeasure20 = ""
    var strSource = ""
    var strTags = ""
    var strYoutube = ""
    var strInstructions = ""

    
    init() {}

    init?(map: Map) {

       }
    mutating func mapping(map: Map) {
        self.idMeal  <- map["idMeal"]
        self.strArea  <- map["strArea"]
        self.strCategory  <- map["strCategory"]
        self.strDrinkAlternate  <- map["strDrinkAlternate"]
        self.strIngredient1  <- map["strIngredient1"]
        self.strIngredient2  <- map["strIngredient2"]
        self.strIngredient3  <- map["strIngredient3"]
        self.strIngredient4  <- map["strIngredient4"]
        self.strIngredient5  <- map["strIngredient5"]
        self.strIngredient6  <- map["strIngredient6"]
        self.strIngredient7  <- map["strIngredient7"]
        self.strIngredient8  <- map["strIngredient8"]
        self.strIngredient9  <- map["strIngredient9"]
        self.strIngredient10  <- map["strIngredient10"]
        self.strIngredient11  <- map["strIngredient11"]
        self.strIngredient12  <- map["strIngredient12"]
        self.strIngredient13  <- map["strIngredient13"]
        self.strIngredient14  <- map["strIngredient14"]
        self.strIngredient15  <- map["strIngredient15"]
        self.strIngredient16  <- map["strIngredient16"]
        self.strIngredient17  <- map["strIngredient17"]
        self.strIngredient18  <- map["strIngredient18"]
        self.strIngredient19  <- map["strIngredient19"]
        self.strIngredient20  <- map["strIngredient20"]
        self.strMeal  <- map["strMeal"]
        self.strMealThumb  <- map["strMealThumb"]
        self.strMeasure1  <- map["strMeasure1"]
        self.strMeasure2  <- map["strMeasure2"]
        self.strMeasure3  <- map["strMeasure3"]
        self.strMeasure4  <- map["strMeasure4"]
        self.strMeasure5  <- map["strMeasure5"]
        self.strMeasure6  <- map["strMeasure6"]
        self.strMeasure7  <- map["strMeasure7"]
        self.strMeasure8  <- map["strMeasure8"]
        self.strMeasure9  <- map["strMeasure19"]
        self.strMeasure10  <- map["strMeasure10"]
        self.strMeasure11  <- map["strMeasure11"]
        self.strMeasure12  <- map["strMeasure12"]
        self.strMeasure13  <- map["strMeasure13"]
        self.strMeasure14  <- map["strMeasure14"]
        self.strMeasure15 <- map["strMeasure15"]
        self.strMeasure16  <- map["strMeasure16"]
        self.strMeasure17  <- map["strMeasure17"]
        self.strMeasure18  <- map["strMeasure18"]
        self.strMeasure19  <- map["strMeasure19"]
        self.strMeasure20  <- map["strMeasure20"]
        self.strSource  <- map["strSource"]
        self.strTags   <- map["strTags"]
        self.strYoutube  <- map["strYoutube"]
        self.strInstructions  <- map["strInstructions"]

    }
}
