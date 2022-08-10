//
//  DoctorModel.swift
//  DocFinder
//
//

import Foundation
class DoctorModel{
    
    var id:Int = 000
    var name:String = ""
    var address:String = ""
    var city:String = ""
    var state:String = ""
    var pincode:String = ""
    var phone:String = ""
    var specialist:String = ""
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    var distance:Double = 0.0
    
    init(data: [String:Any]) {
        if let id = data["id"] as? Int {
            self.id = id
        }
        if let name = data["name"] as? String {
            self.name = name
        }
        if let address = data["address"] as? String {
            self.address = address
        }
        if let city = data["city"] as? String {
            self.city = city
        }
        if let state = data["state"] as? String {
            self.state = state
        }
        if let pincode = data["pincode"] as? String {
            self.pincode = pincode
        }
        if let phone = data["phone"] as? String {
            self.phone = phone
        }
        if let speciality = data["speciality"] as? String {
            self.specialist = speciality
        }
        if let latitude = data["latitude"] as? Double {
            self.latitude = latitude
        }
        if let longitude = data["longitude"] as? Double {
            self.longitude = longitude
        }
        if let distance = data["distance"] as? Double {
            self.distance = distance
        }
        
    }
}
