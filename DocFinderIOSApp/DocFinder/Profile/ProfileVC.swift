//
//  ProfileVC.swift
//  DocFinder
//
//

import UIKit

class ProfileVC: UIViewController {
    
    
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.logoutButton.makeCornerRadious(readious: 5)
        self.logoutButton.makeBorderWidth(width: 2, color: .blue)
        if let name = UserDefaults.standard.value(forKey: AppConstants.UserDefaults.name) as? String {
            self.nameTF.text = name
        }
        if let email = UserDefaults.standard.value(forKey: AppConstants.UserDefaults.email) as? String {
            self.emailTF.text = email
        }
        
    }
 
    @IBAction func LogoutButtonAction(_ sender: UIButton) {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        UserDefaults.standard.removeObject(forKey: AppConstants.UserDefaults.isLoggedIn)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let loginVC = LoginVC.instantiate(storyBoardName: "Main") as LoginVC
            let navController = UINavigationController(rootViewController: loginVC)
            navController.isNavigationBarHidden = true
            (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = navController
        }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    
}
