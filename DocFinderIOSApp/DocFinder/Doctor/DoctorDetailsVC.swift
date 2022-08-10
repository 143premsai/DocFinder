//
//  DoctorDetailsVC.swift
//  DocFinder
//
//

import UIKit

class DoctorDetailsVC: UIViewController {
    
    
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var doctorPhonw: UILabel!
    @IBOutlet weak var doctorType: UILabel!
    @IBOutlet weak var doctorLocation: UIButton!
    
    var doctorDetails:DoctorModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUpUI()
    }
    
    func setUpUI() {
        self.doctorName.text = "Dr.\(self.doctorDetails?.name ?? "")"
        self.doctorPhonw.text = self.doctorDetails?.phone
        self.doctorLocation.setTitle("\(self.doctorDetails?.address ?? "") ,\(self.doctorDetails?.city ?? "")", for: .normal)
        self.doctorType.text = self.doctorDetails?.specialist
    }
 
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func docMapAction(_ sender: UIButton) {
        let doctorMapVC = DoctorMapVC.instantiate(storyBoardName: "Main") as DoctorMapVC
        doctorMapVC.doctorDetails = self.doctorDetails
        self.navigationController?.pushViewController(doctorMapVC, animated: false)
    }
    
    
}
