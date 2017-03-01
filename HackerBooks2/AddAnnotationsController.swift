//
//  AddAnnotationsController.swift
//  HackerBooks2
//
//  Created by David Cava Jimenez on 28/2/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import HTProgressHUD
import CoreGraphics


class AddAnnotationsController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
    
    
    let picker = UIImagePickerController()
    
    var context : NSManagedObjectContext!
    
    var locationManager: CLLocationManager?
    
    var book : Book!
    
    var latitude : Double = 0.0
    var longitude: Double = 0.0
    
    var progressHUD : HTProgressHUD = HTProgressHUD();


    
    @IBOutlet weak var lbText: UITextField!
    

    @IBAction func btnAnadir(_ sender: AnyObject) {
        
        progressHUD.text = "Cargando..."
        progressHUD.show(in:  (UIApplication.shared.delegate?.window)! )

        runLocationManager()

        
    }
    @IBAction func btnTakePicture(_ sender: AnyObject) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true, completion: nil)
        
    }

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        picker.delegate = self
        
    }

    func runLocationManager(){
    
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
    
    }
    
    func getAddressForLocation(){
    
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: self.latitude, longitude: self.longitude)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // Address dictionary
            
            if let street = placeMark.addressDictionary!["Street"] as? String {
            
                self.saveAnnotations(street: street )
            }
 
            
        })
    
    
    }
    
    func saveAnnotations( street: String){
    
        let annotation : Annotation = context.insertObject()
        let photo : Photo = context.insertObject()
        let localization : Localization = context.insertObject()
        
        annotation.text = self.lbText.text ?? ""
        photo.photo = UIImagePNGRepresentation( imageView.image! ) as NSData?
        annotation.photo = photo
        localization.latitud = self.latitude
        localization.longitud = self.longitude
        localization.direccion = street
        annotation.book = self.book
        annotation.localization = localization
        
        try! context.save()
        
        
        DispatchQueue.main.async {
            self.progressHUD.hide()
            let _ = self.navigationController?.popViewController(animated: true)
          
        }
    
    }
    
    
    //MARK: - Delegates
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
        
            progressHUD.text = "Cargando..."
            progressHUD.show(in:  (UIApplication.shared.delegate?.window)! )
            
            
            //Intentamos optimizar la imagen porque
            //es demasiado grande y consume mucha memoria
            
            let screenBounds = UIScreen.main.bounds
            let screenScale = UIScreen.main.scale
            
            let screenSize : CGSize = CGSize(width: screenBounds.size.width * screenScale, height: screenBounds.size.height * screenScale )
            
            
            DispatchQueue.main.async {
                self.imageView.contentMode = .scaleAspectFit
                self.imageView.image = pickedImage.resizedImage(screenSize, interpolationQuality: CGInterpolationQuality.medium)
                
                self.progressHUD.hide()
            }

            
        
        }
        
        dismiss(animated: true, completion: nil)

    
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if(picker.sourceType == UIImagePickerControllerSourceType.photoLibrary){
            let button = UIBarButtonItem(title: "Toma una foto", style: UIBarButtonItemStyle.plain, target: self, action: #selector(AddAnnotationsController.showCamera))
            viewController.navigationItem.rightBarButtonItem = button
        }else{
            let button = UIBarButtonItem(title: "Accede a tus imagenes", style: UIBarButtonItemStyle.plain, target: self, action: #selector(AddAnnotationsController.choosePicture))
            viewController.navigationItem.rightBarButtonItem = button
            viewController.navigationController?.isNavigationBarHidden = false
            viewController.navigationController?.navigationBar.isTranslucent = true
        }
    }
    
    func showCamera(){
        picker.sourceType = UIImagePickerControllerSourceType.camera
    }
    
    func choosePicture(){
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        locationManager?.stopUpdatingLocation()
        locationManager = nil
       // print(locations.first.debugDescription)
        
        self.latitude = (locations.last?.coordinate.latitude)!
        self.longitude = (locations.last?.coordinate.longitude)!
       
        getAddressForLocation()

    }
}
