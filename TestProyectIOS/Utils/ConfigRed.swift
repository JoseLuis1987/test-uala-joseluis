//
//  ConfigRed.swift
//  TestProyectIOS
//
//  Created by Jose Luis on 25/12/20.
//  Copyright © 2020 Jose Luis. All rights reserved.
//

import Foundation


enum Ambiente : Int {
    case Produccion;
    case Desarrollo;
    case QA;
    case PreProduccion;
}
public class ConfigRed{
    static var idAmbiente : Ambiente {
        get{
            return Ambiente.Produccion
        }
    }
    public static var rutaWS : String = {
        switch idAmbiente {
        case .Produccion:
            return "https://www.themealdb.com/api/json/v1/1";
        case .Desarrollo:
            return "";
        case .QA:
            return "";
        case .PreProduccion:
            return "";
        }
    }()
    
}
