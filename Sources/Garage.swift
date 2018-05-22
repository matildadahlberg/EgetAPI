//
//  Garage.swift
//  Perfect-JSON-API
//
//  Created by Matilda Dahlberg on 2018-05-17.
//

import PerfectHTTP

public class Garage {
    // Container for array of type Car
    var data = [Car]()
    
    // Populating with a mock data object
    init(){
        data = [
            Car(model: "Volkswagen polo", regNr: "DTD781", colour: "Black", value: "10000"),
        ]
    }
    // A simple JSON encoding function for listing data members.
    // Ordinarily in an API list directive, cursor commands would be included.
    public func list() -> String {
        return toString()
    }
    
    public func removeCar(regId: String) {
        if let nr = findCarNrBy(regnr: regId) {
            data.remove(at: nr)
        }
        
    }
    
    func findCarNrBy(regnr: String) -> Int? {
        var i = 0
        for car in data {
            if (car.regNr == regnr){
                return i
            }
            i += 1
        }
        return nil
    }
    
    // Accepts the HTTPRequest object and adds a new Car from post params.
    public func add(_ request: HTTPRequest) -> String {
        let new = Car(
            model: request.param(name: "model") ?? "",
            regNr: request.param(name: "regNr") ?? "",
            colour: request.param(name: "colour") ?? "",
            value: request.param(name: "value") ?? ""
        )
        data.append(new)
        return toString()
    }

    // Accepts raw JSON string, to be converted to JSON and consumed.
    public func add(_ json: String) -> String {
        do {
            let incoming = try json.jsonDecode() as! [String: String]
            let new = Car(
                model: incoming["model"] ?? "",
                regNr: incoming["regNr"] ?? "",
                colour: incoming["colour"] ?? "",
                value: incoming["value"] ?? ""
            )
            data.append(new)
        } catch {
            return "ERROR"
        }
        return toString()
    }
    // Convenient encoding method that returns a string from JSON objects.
    private func toString() -> String {
        var out = [String]()
        
        for m in self.data {
            do {
                out.append(try m.jsonEncodedString())
            } catch {
                print(error)
            }
        }
        return "[\(out.joined(separator: ","))]"
    }
}

