//
//  ResultsController+FetchedResultsController.swift
//  HackerBooks2
//
//  Created by David Cava Jimenez on 1/3/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//

import Foundation


import Foundation
import CoreData

extension ResultsController: NSFetchedResultsControllerDelegate {
    
    var fetchedResultsController: NSFetchedResultsController<Book> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        _fetchedResultsController = NSFetchedResultsController(fetchRequest: Book.fetchRequestFilter(searchText: searchText), managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: nil)
        _fetchedResultsController?.delegate = self
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    
    // MARK: - NSFetchedResultController delegate
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        self.tableView.beginUpdates()
        
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            self.tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            self.tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            self.tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            self.tableView.deleteRows(at: [indexPath!], with: .fade)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }

    
    
}
