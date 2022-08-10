//
//  AppConstants.swift
//  DocFinder
//
//

import Foundation
class AppConstants {
    
    static let baseUrl = "http://iosdocfinder.000webhostapp.com/"
    
    static let register = "register.php"
    static let login = "login.php"
    static let get_near_by_doctors = "get_near_by_doctors.php"
    static let get_doctors_by_speciality = "get_doctors_by_speciality.php"
    static let change_password = "change_password.php"
    
    
    struct UserDefaults {
        static let isLoggedIn = "isLoggedIn"
        static let userId = "userId"
        static let email = "email"
        static let name = "name"
    }
}
