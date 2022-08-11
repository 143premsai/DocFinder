//
//  RegistrationVC.swift
//  DocFinder
//
//

import UIKit

class RegistrationVC: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var reTypePasswordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signUpButton.makeCornerRadious(readious: 5)
        self.signUpButton.makeBorderWidth(width: 2, color: .black)
        self.signUpButton.addColor(buttonColor: greenColor, titleColor: UIColor.black)
        nameTF.addAccessoryView()
        emailTF.addAccessoryView()
        passwordTF.addAccessoryView()
        reTypePasswordTF.addAccessoryView()
        
       
        let tapDimissKeyboard = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard));
        view.addGestureRecognizer(tapDimissKeyboard);
        
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }

    
    @IBAction func signUpAction(_ sender: UIButton) {
        dismissKeyboard()
        if nameTF.text?.count == 0 {
            Utility.toastViewForNavigationBar(messsage: "Please enter your Name", view: self.view)
        }else if (!validateName(enteredName: nameTF.text!)){
            Utility.toastViewForNavigationBar(messsage: "Invalid name format\nName should contain only alphabets,space", view: self.view)
        }else if emailTF.text?.count == 0 {
            Utility.toastViewForNavigationBar(messsage: "Please enter your Email", view: self.view)
        }else if (!validateEmail(enteredEmail: emailTF.text!)){
            Utility.toastViewForNavigationBar(messsage: "Invalid email format", view: self.view)
        }else if passwordTF.text?.count == 0 {
            Utility.toastViewForNavigationBar(messsage: "Please enter your password", view: self.view)
        }else if (passwordTF.text!.count < 5){
            Utility.toastViewForNavigationBar(messsage: "Password should contain atleast 5 characters", view: self.view)
        }else if passwordTF.text! != self.reTypePasswordTF.text! {
            Utility.toastViewForNavigationBar(messsage: "Passwords are not matching", view: self.view)
        }else{
            self.signUpApiCall()
        }
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    
    func signUpApiCall() {
        let url = AppConstants.baseUrl + "\(AppConstants.register)"
        let headers = ["Content-Type": "Application/json"]
        let params = ["email":self.emailTF.text!,
                      "password":self.passwordTF.text!,
                      "name":self.nameTF.text!]
        APIManager.callPost(url: URL(string: url)!, params: params,headers: headers) { str, result in
            if result != nil {
                if let data = String(data: result!, encoding: .utf8) as? String  {
                    if let dict = data.convertToDictionary() {
                        if let error = dict["error"] as? Bool ,error == true{
                            if let message = dict["message"] as? String {
                                Utility.showAlert(head: "Error", message: message)
                            }
                        }else{
                            Utility.showAlert(head: "Successfull", message: "Registration Successfull!!\nRedirecting to login !!!")
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
