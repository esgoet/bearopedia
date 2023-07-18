//
//  WebBrowserViewController.swift
//  EvaGoetzke
//
//  Created by Eva Goetzke on 01/03/2022.
//

import UIKit
import WebKit

class WebBrowserViewController: UIViewController {
    
    var speciesData : Species!
    
    @IBOutlet var webView: WKWebView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    func loadUrl() {
        if let searchUrl = searchBar.text {
            guard let myURL = URL(string: searchUrl) else {
                searchBar.text = webView.url?.absoluteString
                searchBar.resignFirstResponder()
                return
            }
            let myRequest = URLRequest(url: myURL)
            webView.load(myRequest)
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        if (webView.canGoBack) { //allow the user to go back to the previous page.
            webView.goBack()
        }
    }
    
    @IBAction func forwardAction(_ sender: Any) {
        if (webView.canGoForward) { //allow the user to go back to the previous page.
            webView.goForward()
        }
    }
    
    @IBAction func refreshAction(_ sender: Any) {
        self.webView.reload()
    }
    
    @IBAction func safariAction(_ sender: Any) {
        if let url = webView.url {
            UIApplication.shared.open(url)
        }
    }
    
    
    @IBAction func goAction(_ sender: Any) {
       loadUrl()
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)

        
        searchBar.delegate = self
        searchBar.text = speciesData.url
        if traitCollection.userInterfaceStyle == .dark {
            searchBar.searchTextField.textColor = UIColor.lightGray
        } else {
            searchBar.searchTextField.textColor = UIColor.darkGray
        }
        searchBar.searchTextField.clearButtonMode = UITextField.ViewMode.unlessEditing
        
        loadUrl()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
           
           if keyPath == "estimatedProgress" {
               progressBar.progress = Float(webView.estimatedProgress)
               
           }
    }
}

extension WebBrowserViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        loadUrl()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.searchTextField.textColor = UIColor.white
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if traitCollection.userInterfaceStyle == .dark {
            searchBar.searchTextField.textColor = UIColor.lightGray
        } else {
            searchBar.searchTextField.textColor = UIColor.darkGray
        }
        
        if !searchBar.searchTextField.hasText {
            searchBar.text = webView.url?.absoluteString
        }
    }
}

extension WebBrowserViewController : WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        progressBar.isHidden = false
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        
        searchBar.text = webView.url?.absoluteString
        
        if (webView.canGoBack) {
            backButton.isEnabled = true
        } else {
            backButton.isEnabled = false
        }
        
        if (webView.canGoForward) {
            forwardButton.isEnabled = true
        } else {
            forwardButton.isEnabled = false
        }
        sleep(1)
        progressBar.isHidden = true
    }
    
    
}
