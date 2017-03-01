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
  
    
    var asyncData: AsyncData {
        get {
            if ( objc_getAssociatedObject(self,&asyncKey) == nil){
                let asyncData = AsyncData(url:  URL(string: (self.imageurl)!)!, defaultData: BookViewCell.defaultImageAsData)
                asyncData.delegate = self
                self.asyncData  = asyncData

            }
            
            return  objc_getAssociatedObject(self,&asyncKey) as! AsyncData
  
        }
        set {
            objc_setAssociatedObject(self, &asyncKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        
    }
    
    
    public func asyncData(_ sender: AsyncData, didEndLoadingFrom url: URL){
        //Ya tengo la cover Image¡¡¡¡
        let nc = NotificationCenter.default
        // Creas un objeto notification
        let notification = Notification(name:UtilsStatics.BookNotification,
                                        object: self, userInfo: [UtilsStatics.bookCoverImage: self])
        nc.post( notification )
    }
}
