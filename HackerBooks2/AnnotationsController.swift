//
//  AnnotationsController.swift
//  HackerBooks2
//
//  Created by David Cava Jimenez on 28/2/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//

import UIKit
import CoreData

class AnnotationsController: UIViewController {
    
    var context: NSManagedObjectContext?
    var _fetchedResultsController: NSFetchedResultsController<Annotation>? = nil
    var book : Book!
    
    @IBOutlet weak var collectionview: UICollectionView!
    


    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        self.navigationItem.leftItemsSupplementBackButton = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddAnnotation"{
            
            let vc = segue.destination as! AddAnnotationsController
            vc.book = book
            vc.context = context
            
        }else if segue.identifier == "MapView"{
            
            let vc = segue.destination as! MapController
            vc.annotations = self.fetchedResultsController.fetchedObjects
        }
        
    }

    

}
