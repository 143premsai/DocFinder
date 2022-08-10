//
//  Extensions.swift
//  DocFinder
//
//

import Foundation
import UIKit
public extension UIView {
    
    
    //MARK:- View setups
    
    /// To make corner radious to a view
    ///
    /// - Parameter readious: radious of that view
    func makeCornerRadious(readious: CGFloat){
        self.layer.cornerRadius = readious
        self.clipsToBounds = true
    }
    
    
    
    /// To make border width of a view
    ///
    /// - Parameters:
    ///   - width: width of border
    ///   - color: color of border
    func makeBorderWidth(width: CGFloat, color: UIColor){
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    /// To make shadow to a view
    ///
    /// - Parameter color: color of shadow
    func makeShadowEffect(color: UIColor){
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 3
    }
    
    func makeShadowForSearchView(){
        let shadowSize : CGFloat = 5.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.frame.size.width + shadowSize,
                                                   height: self.frame.size.height + shadowSize))
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.5
        self.layer.cornerRadius = 5.0
        self.layer.shadowRadius = 5.0
        self.layer.shadowPath = shadowPath.cgPath
    }
}


/// Reusable Code For StoryBoard Instantiation
protocol Storyboarded {
    static func instantiate(storyBoardName name:String) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(storyBoardName name:String) -> Self {
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! Self
    }
}

extension UIViewController:Storyboarded{}

extension UITextField{
    func addAccessoryView(){
        let bar = UIToolbar()
        let reset = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAction))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        bar.items = [flexibleSpace,reset]
        bar.sizeToFit()
        self.inputAccessoryView = bar
    }
    @objc func doneAction(){
        self.resignFirstResponder()
    }
    
    func clear(){
        self.text = ""
    }

    func removeRightView(){
        self.rightView = nil
        self.rightViewMode = .never
    }
}




var blueColor = UIColor.init(rgbColorCodeRed: 0, green: 128, blue: 255, alpha: 1)
var greenColor = UIColor.init(rgbColorCodeRed: 76, green: 175, blue: 80, alpha: 1)

extension UIButton {
    func addColor(buttonColor: UIColor, titleColor: UIColor){
        self.layer.cornerRadius = 22
        self.layer.backgroundColor = buttonColor.cgColor
        self.clipsToBounds = false
        self.layer.shadowOpacity=0.2
        self.setTitleColor(titleColor, for: .normal)
        self.layer.shadowOffset = CGSize(width: 10, height: 10)
    }
}


extension String {
    func convertToDictionary() -> [String: Any]? {
        if let data = data(using: .utf8) {
            return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        }
        return nil
    }
}



extension UIColor {

   convenience init(rgbColorCodeRed red: Int, green: Int, blue: Int, alpha: CGFloat) {

     let redPart: CGFloat = CGFloat(red) / 255
     let greenPart: CGFloat = CGFloat(green) / 255
     let bluePart: CGFloat = CGFloat(blue) / 255

     self.init(red: redPart, green: greenPart, blue: bluePart, alpha: alpha)

   }
}
