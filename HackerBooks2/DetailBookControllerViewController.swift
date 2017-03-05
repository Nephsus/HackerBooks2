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
    
    public static let favoriteBookNotification = Notification.Name(rawValue: "favoriteBookChangeState" )
    public static let keyFavorite = Notification.Name(rawValue: "keyBookChangeState" )

    
    @IBAction func btnFavorite(_ sender: AnyObject) {
        
        if model.favorito {
            model.favorito = false
            sender.setImage( UIImage(named: "btn_check_off_holo_dark_triodos")   , for: .normal)
            
        }else{
            model.favorito = true
            sender.setImage( UIImage(named: "btn_check_on_holo_dark_triodos")   , for: .normal)
            
        }
        
       try! context.save()
        
        notification()
        guard let haveDelegate = self.delegado else {
            return
        }
        
        haveDelegate.reloadDataByRefreshState()
 
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        syncModelView()
        
        subscribeChangeStateBook()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear( animated )
        unsubscribeChangeStateBook()
        
    }
  
    func syncModelView()  {
            self.title = model.title
            self.lbTitle.text = model.title
            self.lbAuthors.text = model.authors
    
            for tag in Array(model.tags!) {
                self.lbTags.text = (tag as! Tag).title

            }

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

    func notification(){
        
        //Creas una instancia del NotificacionCenter
        let nc = NotificationCenter.default
        // Creas un objeto notification
        let notification = Notification(name: DetailBookControllerViewController.favoriteBookNotification,
                                        object: self, userInfo: [ DetailBookControllerViewController.keyFavorite : model])
        
        nc.post( notification )
    }

}


extension DetailBookControllerViewController{
    
    func subscribeChangeStateBook(){
        let nc = NotificationCenter.default
        
        nc.addObserver(forName: UtilsStatics.BookNotification,
                                       object: self.model,
                                       queue: nil) {
                                        (nc) in
                                      
                                        DispatchQueue.main.async {
                                             self.syncModelView()
                                        }
                                       
                                        
                                        
                                        
        }
        
    }
    
    func unsubscribeChangeStateBook(){
        let nc = NotificationCenter.default
        nc.removeObserver(self)
        
    }
    
}
