//
//  Car.swift
//  Perfect-JSON-API
//
//  Created by Matilda Dahlberg on 2018-05-17.
//

import PerfectLib

class Car : JSONConvertibleObject {
    
    static let registerName = "car"
    
    var model: String = ""
    var regNr: String = ""
    var colour: String = ""
    var value: String = ""
    
    var car: String {
        return "\(model) \(regNr) \(colour) \(value)"
    }
    
    init(model: String, regNr: String, colour: String, value: String) {
        self.model = model
        self.regNr = regNr
        self.colour = colour
        self.value = value
    }
    
    override public func setJSONValues(_ values: [String : Any]) {
        self.model = getJSONValue(named: "model", from: values, defaultValue: "")
        self.regNr = getJSONValue(named: "regNr", from: values, defaultValue: "")
        self.colour = getJSONValue(named: "colour", from: values, defaultValue: "")
        self.value = getJSONValue(named: "value", from: values, defaultValue: "")
    }
    override public func getJSONValues() -> [String : Any] {
        return [
            "model":model,
            "regNr":regNr,
            "colour":colour,
            "value":value
        ]
    }
    
}

