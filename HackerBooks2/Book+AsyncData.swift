//
//  Book+AsyncData.swift
//  HackerBooks2
//
//  Created by David Cava Jimenez on 24/2/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//

import Foundation
import ObjectiveC


private var asyncKey: UInt8 = 0 // We still need this boilerplate

extension Book : AsyncDataDelegate {
    
   // static let BookNotification = Notification.Name(rawValue: "BookLoaded" )
   // static let bookCoverImage = Notification.Name(rawValue: "BookCoverImage" )
    
    
    
    
    var asyncData: AsyncData { // cat is *effectively* a stored property
        get {
            return objc_getAssociatedObject(self,&asyncKey) as! AsyncData
        }
        set { //objc_setAssociatedObject(self, &asyncKey, value: newValue,
        
           objc_setAssociatedObject(self, &asyncKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
    }
    
    
    public func asyncData(_ sender: AsyncData, didEndLoadingFrom url: URL){
        //Ya tengo la cover Image¡¡¡¡
        let nc = NotificationCenter.default
        // Creas un objeto notification
        let notification = Notification(name:Notification.Name(rawValue: "BookLoaded" ),
                                        object: self, userInfo: [ Notification.Name(rawValue: "BookCoverImage" ): self])
        nc.post( notification )
    }
}
