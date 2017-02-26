//
//  AppDelegate.swift
//  HackerBooks2
//
//  Created by David Cava Jimenez on 23/2/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//

import UIKit
import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    

    private let StoreURL : URL = MyFileManager.urlDocumentAppendStringPath(endedPath: "HACKERBOOKS")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

       
        let context = setupCoreDataStack()        
        injectContextToFirstViewController (context:  context )
        
        
        return true
    }
    
    
    
    public func setupCoreDataStack()-> NSManagedObjectContext {
        
        let bundles = [Bundle(for: Book.self)]
        guard let model = NSManagedObjectModel.mergedModel(from: bundles ) else {
            fatalError("Error al inicializar CoreData")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        context.persistentStoreCoordinator = psc
        //PONER ESTO EN SEGUNDO PLANO DCJ
        //DispatchQueue.global( DispatchQueue.GlobalQueuePriority.background ).async {
        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: self.StoreURL, options: nil)
            
        } catch {
            fatalError("Error migrating store: \(error)")
        }
        //}
        
        return context
        
    }
    
    func injectContextToFirstViewController( context: NSManagedObjectContext ) {
        if let navController = window?.rootViewController as? UINavigationController,
            let initialViewController = navController.topViewController as? LibraryController
        {
            initialViewController.context = context
        }
    }
    
    

}

