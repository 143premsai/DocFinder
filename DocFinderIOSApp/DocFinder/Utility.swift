//
//  Utility.swift
//  DocFinder
//
//

import Foundation
import UIKit

// Validating Email with regex pattern match
func validateEmail(enteredEmail:String) -> Bool {

    let emailFormat = "[A-Z0-9a-z._-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
    return emailPredicate.evaluate(with: enteredEmail)

}

// Validating name of the user should contain only alphabets & Space
func validateName(enteredName:String) -> Bool {

    let nameFormat = "[ A-Za-z]+"
    let namePredicate = NSPredicate(format:"SELF MATCHES %@", nameFormat)
    return namePredicate.evaluate(with: enteredName)

}

// Utility for extending the functionality
class Utility {
    static var toastView = UIView()
    static var toastViewLabel = UILabel()
    
    // Navigation bar toast for display error messages
    class  func toastViewForNavigationBar(messsage : String,fromHome: Bool? = false, view: UIView){
        toastView.removeFromSuperview()
        DispatchQueue.main.async {
            let y = view.safeAreaLayoutGuide.layoutFrame.minY
            toastView.frame = CGRect(x: 0, y: y ,width: view.bounds.width, height : 0)
            toastViewLabel.frame = CGRect(x: 20, y: 0 ,width: view.bounds.width - 40, height : 0)
            toastViewLabel.textColor = .white
            toastViewLabel.textAlignment = NSTextAlignment.center;
            toastViewLabel.alpha = 1.0
            toastViewLabel.text = messsage
            toastViewLabel.numberOfLines = 0
            toastViewLabel.clipsToBounds  =  true
            
            if !toastView.isDescendant(of: view){
                toastView.addSubview(toastViewLabel)
                view.addSubview(toastView)
            }
            toastViewLabel.layer.removeAllAnimations()
            toastView.layer.removeAllAnimations()
            
            UIView.animate(withDuration: 0.3,delay:0,options: .curveLinear,
                           animations: {
                            toastView.frame =  CGRect(x: 0, y: y ,width: view.bounds.width, height : 50)
                toastView.backgroundColor =  .black
                            toastViewLabel.frame =  CGRect(x: 20, y: 0 ,width: view.bounds.width - 40, height : 50)
                           }){ (Bool) in
                UIView.animate(withDuration: 0.3,delay:3,options: .curveLinear,
                                          animations: {
                                            toastView.frame =  CGRect(x: 0, y: y ,width: view.bounds.width, height : 0)
                                            toastViewLabel.frame =  CGRect(x: 20, y: 10 ,width: view.bounds.width - 40, height : 0)
                           }) { (Bool) in
                    toastView.removeFromSuperview()
                           }
              }
            
        }
    }
    
    // Loading Popup Actions
    // Show
    class func showPI() {
        let activityData = ActivityData(size: CGSize(width: 30,height: 30),
                                        message: "Loading" + "...",
                                        type: NVActivityIndicatorType(rawValue: 29),
                                        color: UIColor.white,
                                        padding: nil,
                                        displayTimeThreshold: nil,
                                        minimumDisplayTime: nil)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    // Hide
    class func hidePI() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    // Showing Alert popup
    class func showAlert(head:String, message:String ) {
        
        let alert = UIAlertController(title: head, message: message, preferredStyle: UIAlertController.Style.alert)
        
       alert.addAction(UIAlertAction(title: "OK", style: .default))
        if  UIApplication.getTopMostViewController()!.isKind(of: UIAlertController.self) {
            print("UIAlertController is already presented")
        }else{
           DispatchQueue.main.async {
               UIApplication.getTopMostViewController()?.present(alert, animated: true, completion: nil)
           }
        }
    }
    
}


extension UIApplication {
    
    ///It returns top most view controller
    class func getTopMostViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopMostViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopMostViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopMostViewController(base: presented)
        }
        return base
    }
}
