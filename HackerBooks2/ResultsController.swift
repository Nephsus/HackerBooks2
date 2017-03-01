//
//  ResultsController.swift
//  HackerBooks2
//
//  Created by David Cava Jimenez on 1/3/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//

import UIKit
import CoreData

class ResultsController: UITableViewController {
    
    var context : NSManagedObjectContext!
    var _fetchedResultsController: NSFetchedResultsController<Book>? = nil
    var searchText : String!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        let cell = UINib(nibName: "BookViewCell", bundle: nil)
        self.tableView.register(cell, forCellReuseIdentifier: BookViewCell.CELLID)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: BookViewCell.CELLID) as! BookViewCell
       let book = self.fetchedResultsController.object(at: indexPath )
        cell.startView(book: book)
        
        
        return cell
 
   }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
        
    }
    
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! BookViewCell).stopObserving()
    }


   
    
    
    
}
