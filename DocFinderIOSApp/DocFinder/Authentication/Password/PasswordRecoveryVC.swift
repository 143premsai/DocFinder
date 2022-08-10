//
//  PasswrodRecoveryVC.swift
//  DocFinder
//
//

import UIKit

class PasswordRecoveryVC: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var retypePasswordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.submitBtn.makeCornerRadious(readious: 5)
        self.submitBtn.makeBorderWidth(width: 2, color: .black)
        self.emailTF.addAccessoryView()
        self.passwordTF.addAccessoryView()
        self.retypePasswordTF.addAccessoryView()
        
        self.submitBtn.addColor(buttonColor: blueColor, titleColor: UIColor.white)
        
        // Dismiss the keyboard on touch
        let tapDimissKeyboard = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard));
        view.addGestureRecognizer(tapDimissKeyboard);
    }
    
    // end editing dismiss keyboard
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
       if emailTF.text?.count == 0 {
            Utility.toastViewForNavigationBar(messsage: "Please enter your email", view: self.view)
        }else if (!validateEmail(enteredEmail: emailTF.text!)){
            Utility.toastViewForNavigationBar(messsage: "Invalid email format", view: self.view)
        }else if passwordTF.text?.count == 0 {
            Utility.toastViewForNavigationBar(messsage: "Please enter your password", view: self.view)
        }else if passwordTF.text! != self.retypePasswordTF.text! {
            Utility.toastViewForNavigationBar(messsage: "Passwords are not matching", view: self.view)
        }else{
            self.changePasswordApiCall()
        }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    func changePasswordApiCall() {
        let url = AppConstants.baseUrl + "\(AppConstants.change_password)"
        let headers = ["Content-Type": "Application/json"]
        let params = ["email":self.emailTF.text!,
                      "password":self.passwordTF.text!]
        APIManager.callPost(url: URL(string: url)!, params: params,headers: headers) { str, result in
            if result != nil {
                if let data = String(data: result!, encoding: .utf8) as? String  {
                    if let dict = data.convertToDictionary() {
                        if let error = dict["error"] as? Bool ,error == true{
                            if let message = dict["message"] as? String {
                                Utility.showAlert(head: "Error", message: message)
                            }
                        }else{
                            Utility.showAlert(head: "Successfull", message: "Password Changed Successfull!!\nRedirecting to login !!!")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                let loginVC = LoginVC.instantiate(storyBoardName: "Main") as LoginVC
                                let navController = UINavigationController(rootViewController: loginVC)
                                navController.isNavigationBarHidden = true
                                (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = navController
                            }
                        }
                    }
                }
            }
        }
    }
    
}
