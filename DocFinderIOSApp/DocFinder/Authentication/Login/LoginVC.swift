//
//  LoginVC.swift
//  DocFinder
//
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var userNameTF: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginBtn.makeBorderWidth(width: 2, color: .black)
        self.loginBtn.makeCornerRadious(readious: 5)
        self.loginBtn.addColor(buttonColor: blueColor, titleColor: UIColor.white)
        
        // Hiding the Default Navigation to display customized navigation bar
        self.navigationController?.navigationBar.isHidden = true
        self.passwordTF.addAccessoryView()
        self.userNameTF.addAccessoryView()
        
        let tapDimissKeyboard = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard));
        view.addGestureRecognizer(tapDimissKeyboard);
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }

    
   
    @IBAction func loginBtnAction(_ sender: UIButton) {
        view.endEditing(true)
        if self.userNameTF.text!.count == 0 {
            Utility.toastViewForNavigationBar(messsage: "Please enter an email", view: self.view)
        }else if (!validateEmail(enteredEmail: userNameTF.text!)){
            Utility.toastViewForNavigationBar(messsage: "Invalid email format\nTry again!!!", view: self.view)
        }else if self.passwordTF.text!.count == 0 {
            Utility.toastViewForNavigationBar(messsage: "Please enter your password", view: self.view)
        }else{
            self.loginApiCall()
        }
        
    }
    

    @IBAction func registrationAction(_ sender: UIButton) {
        let registrationVC = RegistrationVC.instantiate(storyBoardName: "Main") as RegistrationVC
        self.navigationController?.pushViewController(registrationVC, animated: false)
    }
    
    @IBAction func forgotPasswordAction(_ sender: UIButton) {
        let passwordRecoveryVC = PasswordRecoveryVC.instantiate(storyBoardName: "Main") as PasswordRecoveryVC
        self.navigationController?.pushViewController(passwordRecoveryVC, animated: false)
    }
    
    func loginApiCall() {
        let url = AppConstants.baseUrl + "\(AppConstants.login)"
        let headers = ["Content-Type": "Application/json"]
        let params = ["email":self.userNameTF.text!,
                      "password":self.passwordTF.text!
                      ]
       
        
        APIManager.callPost(url: URL(string: url)!, params: params,headers: headers) { str, result in
            if result != nil {
                if let data = String(data: result!, encoding: .utf8) as? String  {
                    if let dict = data.convertToDictionary() {
                        if let error = dict["error"] as? Bool ,error == true{
                            if let message = dict["message"] as? String {
                                Utility.showAlert(head: "Error", message: message)
                            }
                        }else{
                            UserDefaults.standard.set(true, forKey: AppConstants.UserDefaults.isLoggedIn)
                            if let userdetails = dict["user"] as? [String:Any] {
                                if let userid = userdetails["id"] as? Int {
                                    UserDefaults.standard.set(userid, forKey: AppConstants.UserDefaults.userId)
                                }
                                if let email = userdetails["email"] as? String {
                                    UserDefaults.standard.set(email, forKey: AppConstants.UserDefaults.email)
                                }
                                if let name = userdetails["name"] as? String {
                                    UserDefaults.standard.set(name, forKey: AppConstants.UserDefaults.name)
                                }
                            }
                            DispatchQueue.main.async {
                                let homeVC = HomeVC.instantiate(storyBoardName: "Main") as HomeVC
                                self.navigationController?.pushViewController(homeVC, animated: false)
                            }
                        }
                    }
                }
            }

           
            
        }
    }
    
}
