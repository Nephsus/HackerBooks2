//
//  ViewController.swift
//  HackerBooks2
//
//  Created by David Cava Jimenez on 23/2/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//

import UIKit
import CoreData
import HTProgressHUD

class LibraryController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var context : NSManagedObjectContext!
     var _fetchedResultsController: NSFetchedResultsController<Tag>? = nil

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cell = UINib(nibName: "BookViewCell", bundle: nil)
        
        self.tableView.register(cell, forCellReuseIdentifier: BookViewCell.CELLID)

        
    }

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
    
        
        print("elleeee: \(self.fetchedResultsController.sections?.count)")
        return (self.fetchedResultsController.fetchedObjects?.count)!
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       //let sectionInfo = self.fetchedResultsController.sections![section]
       //return sectionInfo.numberOfObjects
        
            let tag = self.fetchedResultsController.object(at: IndexPath(row: section  , section: 0))
           //let tag = self.fetchedResultsController.fetchedObjects.
           print("tags \(tag.title)  \(tag.books?.count)")
        
           return  (tag.books?.count)!
        
        
         //return (tag.books?.count)!
        
        
         //let tag = self.fetchedResultsController.indexPath(forObject: <#T##Tag#>)
        
     //   return 0
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let book = self.fetchedResultsController.object(at: indexPath)
       // let cell = tableView.dequeueReusableCell(withIdentifier: BookViewCell.CELLID) as! BookViewCell
       // cell.startView(book: book)
        //Devolverla
        print("Fila \(indexPath.row)  \(indexPath.section)")
        
        let tag = self.fetchedResultsController.object(at: IndexPath(row: indexPath.section, section: 0))
        
         print("TAG \(tag.title)")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BookViewCell.CELLID) as! BookViewCell
        
        let books = tag.books?.allObjects
        
        let book =  books?[indexPath.row] as! Book
        
        //cell.lbTitle.text = book.title
       
        cell.startView(book: book)
       
        
        return cell

        
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let tag = self.fetchedResultsController.object(at: IndexPath(row: section, section: 0))

        
        return tag.title
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
        
    }
    
    
  /*   func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "prueba"
        
    }*/
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       /* let progressHUD : HTProgressHUD = HTProgressHUD();
        progressHUD.text = "Cargando..."
        progressHUD.show(in:  UIApplication.shared.delegate?.window! )*/

        
    }
    

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! BookViewCell).unsubscribeChangeStateBook()
 
    }




}

