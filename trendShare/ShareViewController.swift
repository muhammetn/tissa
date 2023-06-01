//
//  ShareViewController.swift
//  trendShare
//
//  Created by Muhammet Nurchayev on 14.06.2022.
//

import UIKit
import Social
import CoreServices

class ShareViewController: SLComposeServiceViewController {
    var suitName = "group.trendCopy"
    
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }
    
//    override func viewDidLoad() {
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let appSuit = UserDefaults(suiteName: suitName)
        appSuit?.set(true, forKey: "fromTrendyol")
        appSuit?.set(contentText, forKey: "Name")
        DispatchQueue.main.async {[self] in
            let _ = openURL(URL(string: "shareTrend://mainApp")!)
            self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
        }
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    @objc func openURL(_ url: URL) -> Bool {
        var responder: UIResponder? = self
        while responder != nil {
            if let application = responder as? UIApplication {
                return application.perform(#selector(openURL(_:)), with: url) != nil
            }
            responder = responder?.next
        }
        return false
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
