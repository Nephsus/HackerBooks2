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
    
    public var book: Book?
    
    static let defaultImageAsData = try! Data(contentsOf: Bundle.main.url(forResource: "noImage", withExtension: "png")!)


    static func heightForBooCell() -> CGFloat{
    
       return CGFloat( 66 )
    
    }
    
    
    func startView(book: Book){
        self.book = book
        subscribeChangeStateBook()
        
       let asyncData = AsyncData(url:  URL(string: (self.book?.imageurl)!)!,
                                 defaultData: BookViewCell.defaultImageAsData)
        asyncData.delegate = book
        
        self.book?.asyncData = asyncData
        
        
        syncModelWithView()
        
    }
    
    func syncModelWithView(){
        
      /*  if ( book != nil && book?.asyncData != nil ){
            coverImage.image = UIImage(data: (book?.asyncData.data)!)
        }*/
        coverImage.clipsToBounds = true
        lbTitle.text = self.book?.title
        var literalTag = "";
        
       /* for tag in (self.book?.tags?.allObjects)!{
            literalTag = (tag as! Tag).title! +  "," + literalTag
        }
        
        lbTags.text = literalTag*/
    
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       

    }
    
    override func prepareForReuse() {
          unsubscribeChangeStateBook()
          syncModelWithView()
    }
    
    deinit {
          unsubscribeChangeStateBook()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension BookViewCell{
    
    func subscribeChangeStateBook(){
        let nc = NotificationCenter.default
        
        nc.addObserver(forName: Notification.Name(rawValue: "BookLoaded" ), object: self.book, queue: OperationQueue.main) {
                      (nc) in
        let userInfo = nc.userInfo
        self.book = userInfo?[Notification.Name(rawValue: "BookCoverImage" )] as! Book?
        self.syncModelWithView()
            

            
        }
        
    }
    
    func unsubscribeChangeStateBook(){
        let nc = NotificationCenter.default
        nc.removeObserver(self)
        self.book = nil
    }
    
}

