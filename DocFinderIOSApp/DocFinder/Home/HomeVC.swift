//
//  HomeVC.swift
//  DocFinder
//
//

import UIKit
import CoreLocation

class HomeVC: UIViewController {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var doctorsTableView: UITableView!
    
    var selectedSpecialty: String?
    var specialityList = ["Internal Medicine","Respirology","Family Medicine",
                          "Anesthesiology","Cardiology",
                          "Obstetrics","Gynecology","Psychiatry",
                          "Gastroenterology","Otolaryngology","Head",
                          "Neck Surgery","Neurology","Orthopedic",
                          "Dermatology","Rheumatology","Plastic Surgery",
                          "Orthopedic Surgery","Geriatric Medicine",
                          "Endocrinology","Metabolism"]
    
    var dropDownView = UIPickerView()
    var doctorsModelArray = [DoctorModel]()
    var locationManager: CLLocationManager!
    var latitude = 0.0
    var longitude = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchView.makeBorderWidth(width: 2, color: .black)
        self.searchBtn.makeBorderWidth(width: 2, color: .black)
        
        // location functionalities
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager?.requestWhenInUseAuthorization()
        checkLocationPermission()

        // Dropdown functionalities
        dropDownView.delegate = self
        dropDownView.dataSource = self
        searchTF.inputView = dropDownView
        dismissDropDownPickerView()
    }
    
    
    // Onload of View calling the fetchNearbydoctors based on location
    override func viewDidAppear(_ animated: Bool) {
        self.searchTF.text = ""
        self.locationManager.startUpdatingLocation()
        if (self.locationManager.authorizationStatus == .authorizedAlways || self.locationManager.authorizationStatus == .authorizedWhenInUse){
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.fetchNearByDoctors()
            }
        }
        
    }
    
    
    func dismissDropDownPickerView(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self,
                                     action: #selector(self.completedAction))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        searchTF.inputAccessoryView = toolBar
    }
    
    @objc func completedAction(){
        view.endEditing(true)
    }
    
    func fetchNearByDoctors() {
        self.doctorsModelArray.removeAll()
        let url = AppConstants.baseUrl + "\(AppConstants.get_near_by_doctors)"
        let headers = ["Content-Type": "Application/json"]
        
        let params = ["latitude":self.latitude,
                      "longitude":self.longitude,
                      "miles":1] as [String:Any]
        
        APIManager.callPost(url: URL(string: url)!, params: params,headers: headers
        ) { str, result in
            print(result ?? "")
            if result != nil {
                if let data = String(data: result!, encoding: .utf8)  {
                    if let dict = data.convertToDictionary() {
                        if let error = dict["error"] as? Bool ,error == true{
                            Utility.showAlert(head: "Error", message: (dict["message"] as? String)!)
                        }else{
                            if let doctors = dict["doctors"] as? [[String:Any]] {
                                if doctors.count == 0 {
                                    Utility.showAlert(head: "Error", message: (dict["message"] as? String)!)
                                }
                                for data in doctors {
                                    let model = DoctorModel(data: data)
                                    self.doctorsModelArray.append(model)
                                }
                                DispatchQueue.main.async {
                                    self.doctorsTableView.reloadData()
                                }
                                
                            }
                        }
                    }
                    
                }
            }
            
            
        }
        
    }
    
    
    func getDoctorsBySpecialist(search_term: String) {
        self.doctorsModelArray.removeAll()
        let url = AppConstants.baseUrl + "\(AppConstants.get_doctors_by_speciality)"
        let headers = ["Content-Type": "Application/json"]
        
        let params = ["search_term":search_term] as [String:Any]
        APIManager.callPost(url: URL(string: url)!, params: params,headers: headers
        ) { str, result in
            print(result)
            if let data = String(data: result!, encoding: .utf8) as? String  {
                if let dict = data.convertToDictionary() {
                    if let error = dict["error"] as? Bool ,error == true{
                        Utility.showAlert(head: "Error", message: (dict["message"] as? String)!)
                    }else{
                        if let doctors = dict["doctors"] as? [[String:Any]] {
                            if doctors.count == 0 {
                                Utility.showAlert(head: "Error", message: (dict["message"] as? String)!)
                            }
                            for data in doctors {
                                let model = DoctorModel(data: data)
                                self.doctorsModelArray.append(model)
                            }
                            DispatchQueue.main.async {
                                self.doctorsTableView.reloadData()
                            }
                            
                        }
                    }
                }
                
            }
            
        }
        
    }
    

    // Checking the location services and display alert
    func checkLocationPermission(){
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .restricted, .denied:
                let alert = UIAlertController.init(title: "Location Service Disabled", message: "To re-enable ,please go to Settings and turn on Location Service for this app", preferredStyle: .alert)
                let alertAction = UIAlertAction.init(title: "Back", style: .cancel, handler: {_ in
                    self.navigationController?.popViewController(animated: true)
                })
                let alertSettingsAction = UIAlertAction.init(title: "Settings", style: .default) { (settings) in
                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                }
                alert.addAction(alertAction)
                alert.addAction(alertSettingsAction)
                self.present(alert, animated: true, completion: nil)
                break
            case .authorizedAlways, .authorizedWhenInUse:
                self.locationManager.startUpdatingLocation()
                break
            case .notDetermined:
                break
            }
        } else {
            print("Location services are not enabled")
            let alert = UIAlertController.init(title: "Location Service Disabled",
                                               message: "To re-enable ,please go to Settings and turn on Location Service for this app",
                                               preferredStyle: .alert)
            let alertAction = UIAlertAction.init(title: "Back", style: .cancel, handler: {_ in
                self.navigationController?.popViewController(animated: true)
            })
            let alertSettingsAction = UIAlertAction.init(title: "Settings", style: .default) { (settings) in
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            }
            alert.addAction(alertAction)
            alert.addAction(alertSettingsAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // Profile redirect action
    @IBAction func profileAction(_ sender: UIButton) {
        let profileVC = ProfileVC.instantiate(storyBoardName: "Main") as ProfileVC
        self.navigationController?.pushViewController(profileVC, animated: false)
    }
    
    // Search button action
    @IBAction func searchAction(_ sender: UIButton) {
        view.endEditing(true)
        if self.searchTF.text?.count == 0 {
            self.fetchNearByDoctors()
        }else{
            self.getDoctorsBySpecialist(search_term: self.searchTF.text!)
        }
    }
    
}

// Adding Table View Functionality for row
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.doctorsModelArray.count == 0 {
            DispatchQueue.main.async {
                self.setTableViewOrCollectionViewBackground(tableView: self.doctorsTableView, collectionView: nil, image: UIImage(named: "nodoctors"), labelText: "No Doctors Found.", labelWithImage: true, yPosition: 150)
            }
        }else{
            DispatchQueue.main.async {
                self.doctorsTableView.backgroundView = nil
            }
        }
        return self.doctorsModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let doctorCell = tableView.dequeueReusableCell(withIdentifier: String(describing: DoctorsCell.self), for: indexPath) as? DoctorsCell else{return UITableViewCell()}
        doctorCell.doctorNameLabel.text = "Dr.\(self.doctorsModelArray[indexPath.row].name)"
        doctorCell.doctorTypeLabel.text = self.doctorsModelArray[indexPath.row].specialist
        
        return doctorCell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let doctorDetailsVC = DoctorDetailsVC.instantiate(storyBoardName: "Main") as DoctorDetailsVC
        doctorDetailsVC.doctorDetails = self.doctorsModelArray[indexPath.row]
        self.navigationController?.pushViewController(doctorDetailsVC, animated: false)
    }
    
    
    // Used for display no doctors found on the tableview
    func setTableViewOrCollectionViewBackground(tableView: UITableView? , collectionView: UICollectionView?,image : UIImage?,labelText: String?,labelWithImage:Bool , yPosition: CGFloat){
        
        let backgroundView = UIView()
        backgroundView.frame = self.view.bounds
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 25))
        
        if let image = image{
            imageView.image = image
            imageView.center.y = yPosition
            imageView.center.x = self.view.center.x
            imageView.contentMode = .scaleAspectFit
            backgroundView.addSubview(imageView)
        }
        
        if let labelText = labelText{
            label.text = labelText
            label.textAlignment = .center

            if labelWithImage{
                label.center.y = imageView.frame.maxY + 30
                imageView.center.x = self.view.center.x
                backgroundView.addSubview(label)
            }else{
                imageView.center.y = self.view.center.y
                imageView.center.x = self.view.center.x
                backgroundView.addSubview(label)
            }
        }
        
        if let tableView = tableView{
            tableView.backgroundView = backgroundView
        }
        
        if let collectionView = collectionView{
            collectionView.backgroundView = backgroundView
        }
    }
    
}

// Adding Picker for Search Speciality Text field
extension HomeVC: UIPickerViewDelegate,
                  UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return specialityList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return specialityList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSpecialty = specialityList[row]
        searchTF.text = selectedSpecialty
    }
    
    
}

// Adding Location functionality to fetch the current user location details
extension HomeVC : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let _ = locations.first {
            manager.startUpdatingLocation()
            let locationValue:CLLocationCoordinate2D = manager.location!.coordinate
            self.latitude = locationValue.latitude;
            self.longitude = locationValue.longitude;
            print("latitude = \(self.latitude) longitude = \(self.longitude)")
            
        }
        self.fetchNearByDoctors()
        
   }

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied:
            let alert = UIAlertController.init(title: "Location Service Disabled", message: "To re-enable ,please go to Settings and turn on Location Service for this app", preferredStyle: .alert)
            let alertAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: {_ in
                self.navigationController?.popViewController(animated: true)
            })
            let alertSettingsAction = UIAlertAction.init(title: "Settings", style: .default) { (settings) in
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            }
            alert.addAction(alertAction)
            alert.addAction(alertSettingsAction)
            self.present(alert, animated: true, completion: nil)
            break
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            DispatchQueue.main.asyncAfter(deadline: .now()+3){
                self.fetchNearByDoctors()
            }
            break
        case .notDetermined:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
