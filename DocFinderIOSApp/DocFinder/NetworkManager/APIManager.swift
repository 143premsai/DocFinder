//
//  APIManager.swift
//  DocFinder
//
//

import UIKit
class APIManager: NSObject {
    
    class func callPost(url:URL, params:[String:Any],headers: [String:Any], finish: @escaping ((message:String, data:Data?)) -> Void)
       {
           Utility.showPI()
           var request = URLRequest(url: url)
           request.httpMethod = "POST"

           let postString = self.getPostString(params: params)
           request.httpBody = postString.data(using: .utf8)

           var result:(message:String, data:Data?) = (message: "Fail", data: nil)
           let task = URLSession.shared.dataTask(with: request) { data, response, error in
               DispatchQueue.main.async {
                   Utility.hidePI()
               }
               if(error != nil)
               {
                   result.message = "Fail Error not null : \(error.debugDescription)"
               }
               else
               {
                   result.message = "Success"
                   result.data = data
               }

               finish(result)
           }
           task.resume()
       }
   
    class func getPostString(params:[String:Any]) -> String
       {
           var data = [String]()
           for(key, value) in params
           {
               data.append(key + "=\(value)")
           }
           return data.map { String($0) }.joined(separator: "&")
       }

}
