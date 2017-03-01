//
//  AnnotationsCollectionCell.swift
//  HackerBooks2
//
//  Created by David Cava Jimenez on 28/2/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//

import UIKit

class AnnotationsCollectionCell: UICollectionViewCell {
    
    var parentController : AnnotationsController!
    
    @IBOutlet weak var lbText: UILabel!
    
    @IBAction func btnShared(_ sender: AnyObject) {
        // set up activity view controller
         var itemToShare : [ Any ] =  [Any]()

        
        if annotation.photo != nil && ((annotation.photo?.photo) != nil) {
            itemToShare  = [annotation.text ?? "", UIImage(data: (annotation.photo?.photo)! as Data)!]
        }else{
            itemToShare  = [annotation.text ?? ""]
        }
        
        let activityViewController = UIActivityViewController(activityItems: itemToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.parentController.view // so that iPads won't crash
        
       
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.parentController.present(activityViewController, animated: true, completion: nil)
        
        
        
    }
    private var _annotation: Annotation? = nil
    
    var annotation : Annotation{
    
        get{ return self._annotation!}
    
        set{
             self._annotation = newValue
            lbText.text = _annotation?.text
        
        
        }
    }
    
    
    
    
}
