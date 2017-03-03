//
//  DetailBookControllerViewController.swift
//  HackerBooks2
//
//  Created by David Cava Jimenez on 28/2/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//

import UIKit
import CoreData

class DetailBookControllerViewController: UIViewController, UISplitViewControllerDelegate  {
    
    var model : Book!
    var context : NSManagedObjectContext!
    
    weak var delegado : TableRefresh? = nil
    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbAuthors: UILabel!
    
    @IBOutlet weak var lbTags: UILabel!
    
    
    @IBOutlet weak var btnPDF: UIButton!
    
    @IBOutlet weak var btnFavoriteOutlet: UIButton!
    
    @IBOutlet weak var coverImage: UIImageView!

    
    @IBAction func btnFavorite(_ sender: AnyObject) {
        
        if model.favorito {
            model.favorito = false
            sender.setImage( UIImage(named: "btn_check_off_holo_dark_triodos")   , for: .normal)
            
        }else{
            model.favorito = true
            sender.setImage( UIImage(named: "btn_check_on_holo_dark_triodos")   , for: .normal)
            
        }
        
       try! context.save()
        
       // notification()
        guard let haveDelegate = self.delegado else {
            return
        }
        
        haveDelegate.reloadDataByRefreshState()
 
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        syncModelView()
        
        // Do any additional setup after loading the view.
    }
    
    

        
        func syncModelView()  {
            self.title = model.title
            self.lbTitle.text = model.title
            self.lbAuthors.text = model.authors
            
            var count = 0
            
            for tag in Array(model.tags!) {
            
                if count == 0{
                self.lbTags.text = (tag as! Tag).title
                }else{
                self.lbTags.text = self.lbTags.text! + "," + (tag as! Tag).title!
                }
            }
            
            
            // self.lbTags.text = model.tags.joined(separator: ",")
            
            
            
            
            if model.favorito  {
                btnFavoriteOutlet.setImage( UIImage(named: "btn_check_on_holo_dark_triodos")   , for: .normal)
                
            }else{
                btnFavoriteOutlet.setImage( UIImage(named: "btn_check_off_holo_dark_triodos")   , for: .normal)
                
            }

            coverImage.image = UIImage(data: model.asyncData.data)
            
        }
        
        
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PdfSegue"{
            
            let vc = segue.destination as! PdfViewController
            vc.context = context
            vc.model = model
            
        }
        
    }

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        return true
    }

    func primaryViewController(forCollapsing splitViewController: UISplitViewController) -> UIViewController? {
        print("dfsadf")
        return nil
    }
  
    
    func primaryViewController(forExpanding splitViewController: UISplitViewController) -> UIViewController? {
        print("dafsdf")
        return nil
    }

    func splitViewController(_ splitViewController: UISplitViewController, separateSecondaryFrom primaryViewController: UIViewController) -> UIViewController? {
        print("fdfd")
        return nil
    }
   

}
