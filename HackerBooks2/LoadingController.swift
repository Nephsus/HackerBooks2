//
//  LoadingController.swift
//  HackerBooks2
//
//  Created by David on 27/2/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//

import UIKit
import HTProgressHUD
import CoreData

class LoadingController: UIViewController {
    
     var context : NSManagedObjectContext!
    
     var progressHUD : HTProgressHUD = HTProgressHUD();
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        progressHUD.text = "Cargando..."
        progressHUD.show(in:  self.view )

        let defaults = UserDefaults.standard
        
        if !defaults.bool(forKey: "AlreadyInitialized"){
            let initialInteractor = GetBooksInteractor()
            initialInteractor.context = context
            
            
            
            initialInteractor.executeOperation {
                let defaults = UserDefaults.standard
                defaults.set(true, forKey: "AlreadyInitialized")
                
               self.showNextViewController()
            }
        }else{
           showNextViewController()
        
        }

        // Do any additional setup after loading the view.
    }

    private func showNextViewController(){
    
        DispatchQueue.main.async {
            self.progressHUD.hide()
            self.performSegue(withIdentifier: "Library", sender: nil)
        }
    }
    
    // MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
      //  YourViewController *vc = [segue destinationViewController];
      /*  let vc = segue.destination as! UINavigationController
        
        guard let controller = vc.topViewController as? LibraryController else{
            return
        }
        
        controller.context = context*/
        
        //Aquí es donde recupero el splitview y le digo que su delegado es el controller de detalle DetailBookController,
        //pero no me salta el método 
        
        let destinationViewController : UIViewController = segue.destination;
        
        let splitViewController : UISplitViewController = destinationViewController as! UISplitViewController;
        let navigationController : UINavigationController = splitViewController.viewControllers.last as! UINavigationController
        
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        
        splitViewController.delegate =  navigationController.topViewController as! UISplitViewControllerDelegate?; //le seteo el deatail como DetailBookController como delegate y nada¡¡
        
        let  window = UIApplication.shared.keyWindow;
        
        
            
            window?.rootViewController = destinationViewController;
            

            
        

        
        
  
        
    }
 

}
