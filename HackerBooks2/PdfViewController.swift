//
//  PdfViewController.swift
//  HackerBooks
//
//  Created by David Cava Jimenez on 4/2/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//

import UIKit
import CoreData
import WebKit

class PdfViewController: UIViewController, WKUIDelegate {
    var model : Book!
    var context : NSManagedObjectContext!
    
    public static var defaultImageAsData : Data! = try! Data(contentsOf: Bundle.main.url(forResource: "pdftest", withExtension: "pdf")!)


    
    @IBOutlet weak var webView: UIWebView!
    
    
    //var wkWebView: WKWebView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backItem?.title = "Volver";
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        PdfViewController.defaultImageAsData  = try! Data(contentsOf: Bundle.main.url(forResource: "pdftest", withExtension: "pdf")!)
        //subscribe()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear( animated )
        
        //defaultImageAsData = try! Data(contentsOf: Bundle.main.url(forResource: "pdftest", withExtension: "pdf")!)
        //let webConfiguration = WKWebViewConfiguration()
        //wkWebView = WKWebView(frame:  lereView.frame, configuration: webConfiguration)
        //wkWebView.uiDelegate = self
        //self.lereView.addSubview( wkWebView )
        
        syncModelView()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
        PdfViewController.defaultImageAsData = nil
        /*self.wkWebView.loadHTMLString("", baseURL: nil)
        self.wkWebView.stopLoading()
        self.wkWebView.uiDelegate = nil
        self.wkWebView.removeFromSuperview()*/
        
        self.webView.loadHTMLString("", baseURL: nil)
        self.webView.stopLoading()
        self.webView.delegate = nil
        //self.webView.removeFromSuperview()
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        
        
        //unsubscribe()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AnnotationsView"{
            
            let vc = segue.destination as! AnnotationsController
            vc.book = model
            vc.context = context
            
        }
        
    }
    
    func syncModelView(){
       
        if let pdfdata = model.pdf?.pdfData{
            webView.load( pdfdata as Data, mimeType: "application/pdf",
                          textEncodingName: "utf8", baseURL: URL(string:"http://www.google.es")!)
        }else{
            let asyncData = AsyncData(url: URL(string:self.model.pdfurl!)!, defaultData: PdfViewController.defaultImageAsData)
            asyncData.delegate = self
            webView.load( asyncData.data, mimeType: "application/pdf",
                          textEncodingName: "utf8", baseURL: URL(string:"http://www.google.es")!)
     
        }

    }
    

}








extension PdfViewController: AsyncDataDelegate{
    
    func asyncData(_ sender: AsyncData, shouldStartLoadingFrom url: URL) -> Bool {
        // nos pregunta si puede haer la descarga.
        // por supuesto!
        return true
    }
    
    func asyncData(_ sender: AsyncData, willStartLoadingFrom url: URL) {
        // Nos avisa que va a empezar
        print("Viá a empezar a descargar del remoto: \(url)")
    }
    
    func asyncData(_ sender: AsyncData, didEndLoadingFrom url: URL) {
        // la tengo!
        //let data = try? Data(contentsOf: url)
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            let pdfdata : Pdf = self.context.insertObject()
            
            pdfdata.pdfData = sender.data as NSData?
            pdfdata.book = self.model
            
            try! self.context.save()
            
            DispatchQueue.main.async {
                    self.webView.load( sender.data , mimeType: "application/pdf",
                                      textEncodingName: "utf8", baseURL:  URL(string:"http://www.google.es")!)
                
            }
            
            
        }
       
        
        
    }
    
}


extension PdfViewController{
    
   /* func subscribe(){
        let nc = NotificationCenter.default
        
        nc.addObserver(forName: LibraryTableViewController.changeBookNotification,
                       object: nil, queue: OperationQueue.main) { (nc) in
                        //self.syncModelView()
                        let userInfo = nc.userInfo
                        let book = userInfo?[LibraryTableViewController.keyNotification ]
                        self.model = book as! Book
                        self.syncModelView()
        }
        
    }
    
    func unsubscribe(){
        let nc = NotificationCenter.default
        
        nc.removeObserver(self)
        
    }*/
    
    
    
}


