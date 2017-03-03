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

class LibraryController: UIViewController, UITableViewDataSource, UITableViewDelegate, TableRefresh, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating, UISplitViewControllerDelegate  {
    
    var context : NSManagedObjectContext!
    var _fetchedResultsController: NSFetchedResultsController<Tag>? = nil
    var bookSelected : Book!
    
    var searchController: UISearchController!
    
    var resultsController : ResultsController!
    
    var favoritesBooks : [Book]?

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        /*let cell = UINib(nibName: "BookViewCell", bundle: nil)
        self.tableView.register(cell, forCellReuseIdentifier: BookViewCell.CELLID)
        
         loadFavoritesBooks()
        
        resultsController = ResultsController()
        resultsController.context = self.context
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false // default is YES
        searchController.searchBar.delegate = self
 
         definesPresentationContext = true*/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title="HACKERBOOKS"
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    // MARK: - UISearchControllerDelegate
    
    func presentSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }

    
    func updateSearchResults(for searchController: UISearchController) {
       
        resultsController._fetchedResultsController = nil
        resultsController.searchText = searchController.searchBar.text
        resultsController.tableView.reloadData()
        
    }
    
    
    func loadFavoritesBooks(){
        let queryRequest = Book.fetchRequestFavorites()
        self.favoritesBooks = try! context.fetch( queryRequest )
    
    }
    
    func haveFavorites() -> Bool{
        if (favoritesBooks?.count)! > 0 {
            return true
        }
        return false
    }

     func numberOfSections(in tableView: UITableView) -> Int {
        
      /*  if haveFavorites(){
            return ((self.fetchedResultsController.fetchedObjects?.count)! + 1)
        }else{
            return (self.fetchedResultsController.fetchedObjects?.count)!
        }*/
        return 0
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
           //print("tags \(tag.title)  \(tag.books?.count)")
        
            if haveFavorites() && section == 0{
                return (favoritesBooks?.count)!
            }
        
        let tag: Tag
        if haveFavorites(){
            tag = self.fetchedResultsController.object(at: IndexPath(row: section - 1 , section: 0))
        }else{
            tag = self.fetchedResultsController.object(at: IndexPath(row: section, section: 0))
        }
        
           return  (tag.books?.count)!
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: BookViewCell.CELLID) as! BookViewCell
        let book : Book
        
        if haveFavorites() && indexPath.section == 0{
            book =  (favoritesBooks?[ indexPath.row ])!
        }else{
            let tag: Tag
            
            if haveFavorites(){
                tag = self.fetchedResultsController.object(at: IndexPath(row: indexPath.section - 1, section: 0))
                let books = tag.books?.allObjects.sorted(by: { ($0 as! Book).title! < ($1 as! Book).title! })
                book =  books?[indexPath.row] as! Book
            }else{
                tag = self.fetchedResultsController.object(at: IndexPath(row: indexPath.section, section: 0))
                let books = tag.books?.allObjects.sorted(by: { ($0 as! Book).title! < ($1 as! Book).title! })
                book =  books?[indexPath.row] as! Book
            }
            
           
        }

       
        cell.startView(book: book)
       
        
        return cell

        
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if haveFavorites() && section == 0{
        
            return "MIS FAVORITOS"
        }else{
            let tag: Tag
            if haveFavorites(){
                tag = self.fetchedResultsController.object(at: IndexPath(row: section - 1, section: 0))
            }else{
                tag = self.fetchedResultsController.object(at: IndexPath(row: section, section: 0))
            }
            return tag.title
        }
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if haveFavorites() && indexPath.section == 0{
           self.bookSelected = favoritesBooks?[indexPath.row]
            
        }else{
            let tag : Tag
            if haveFavorites() {
                 tag = self.fetchedResultsController.object(at: IndexPath(row: indexPath.section - 1, section: 0))
            }else{
                 tag = self.fetchedResultsController.object(at: IndexPath(row: indexPath.section, section: 0))
            }
                let books = tag.books?.allObjects
                self.bookSelected =  books?[indexPath.row] as! Book
        }
        
        self.performSegue(withIdentifier: "DetailBook", sender: self)
        
        
    }
    

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! BookViewCell).stopObserving()
 
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailBook"{
        
            let vc = segue.destination as! DetailBookControllerViewController
            vc.context = context
            vc.model = bookSelected
            vc.delegado = self
            
        }
        
    }
    
    
    //MARK: Protocolo de refresco debido a un cambio de estado del libro
    func reloadDataByRefreshState() {
        loadFavoritesBooks()
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
        }
        
    }

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        return true
    }


}

