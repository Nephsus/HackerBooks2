//
//  PruebasViewController.swift
//  HackerBooks2
//
//  Created by David Cava Jimenez on 28/2/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//

import UIKit
import WebKit

class PruebasViewController: UIViewController, WKUIDelegate  {

      var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // let myURL = URL(string: "https://www.apple.com")
     //   let myRequest = URLRequest(url: myURL!)
        //webView.load(myRequest)
        
        webView.load(try! Data(contentsOf: Bundle.main.url(forResource: "pdftest", withExtension: "pdf")!),
                     mimeType: "application/pdf",
                     characterEncodingName: "utf8",
                     baseURL: URL(string:"http://www.google.es")!)

}
}
