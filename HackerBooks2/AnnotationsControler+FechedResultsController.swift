//
//  AnnotationsControler+FechedResultsController.swift
//  HackerBooks2
//
//  Created by David Cava Jimenez on 28/2/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//

import Foundation
import CoreData

extension AnnotationsController: NSFetchedResultsControllerDelegate {
    
    var fetchedResultsController: NSFetchedResultsController<Annotation> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        _fetchedResultsController = NSFetchedResultsController(fetchRequest: Annotation.fetchRequestByBook(book: self.book), managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: nil)
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
        
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            self.collectionview.insertSections(IndexSet(integer: sectionIndex))
        case .delete:
            self.collectionview.deleteSections(IndexSet(integer: sectionIndex))
            
        default:
            return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            self.collectionview.insertItems(at:  [newIndexPath!])
        case .delete:
            self.collectionview.deleteItems(at: [indexPath!])
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
    
    
}
