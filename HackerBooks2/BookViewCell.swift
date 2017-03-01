//
//  BookViewCell.swift
//  HackerBooks
//
//  Created by David Cava Jimenez on 9/2/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//

import UIKit

class BookViewCell: UITableViewCell {
    
    public static let CELLID = "MyBookCell"
    
    @IBOutlet weak var coverImage: UIImageView!
    
    
    @IBOutlet weak var lbTitle: UILabel!

    @IBOutlet weak var lbTags: UILabel!
    
    public var _book: Book?
    
    static let defaultImageAsData = try! Data(contentsOf: Bundle.main.url(forResource: "noImage", withExtension: "png")!)

    private
    let _nc = NotificationCenter.default
    public var _bookObserver : NSObjectProtocol?
    
    
    
    static func heightForBooCell() -> CGFloat{
    
       return CGFloat( 66 )
    
    }
    
    
    func startView(book: Book){
       /* self._book = book
        
        
        print("/7/////////////////////STARVIEW @%", self.book?.title )
        
        subscribeChangeStateBook()
        syncModelWithView()*/
        _book = book
      /*  _nc.addObserver(forName: UtilsStatics.BookNotification, object: _book, queue: nil) { (n: Notification) in
            self.syncModelWithView()
        }*/
        subscribeChangeStateBook()
        syncModelWithView()
        
        
    }
    
    func syncModelWithView(){
        
 
        coverImage.image = UIImage(data: (_book?.asyncData.data)!)
        coverImage.clipsToBounds = true
        lbTitle.text = self._book?.title
        lbTags.text = _book?.authors
    
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       

    }
    
    override func prepareForReuse() {
         /// print("++++++++++++++++++++++++++++++++++++++++ prepareForReuse @%", self.book?.title )

      /*    unsubscribeChangeStateBook()
          syncModelWithView()*/
        
        stopObserving()
        syncModelWithView()
    }
    
    func stopObserving(){
        
        if let observer = _bookObserver{
            print("++++++++++++++++++++++++++++++++++++++++ borro observer" )
            _nc.removeObserver(observer)
            _bookObserver = nil
            //_book = nil
        }
        
    }
    
    deinit {
          //unsubscribeChangeStateBook()
        stopObserving()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension BookViewCell{
    
    func subscribeChangeStateBook(){
        let nc = NotificationCenter.default
        
        _bookObserver = nc.addObserver(forName: UtilsStatics.BookNotification,
                       object: self._book,
                       queue: nil) {
                      (nc) in
        
       /* let userInfo = nc.userInfo
            
        print("*********************************************** BOOK ANTES %@", self._book?.title )
            
       // self._book = userInfo?[UtilsStatics.bookCoverImage] as! Book?
            
        print("*********************************************** BOOK DESPPUES %@", self._book?.title )*/
            
        self.syncModelWithView()
            

            
        }
        
    }
    
   /* func unsubscribeChangeStateBook(){
        let nc = NotificationCenter.default
        nc.removeObserver(self)
        //self.book = nil
    }*/
    
}

