//
//  Utility.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 13.06.2022.
//

import Foundation
    // L102Language
class AppLanguage {
    // get current Apple language
    class func currentAppleLanguage() -> String{
        return UserDefaults.standard.string(forKey: "lang") ?? "empty"
    }
    
    class func setAppleLanguageTo(lang: String) {
        UserDefaults.standard.set(lang, forKey: "lang")
        UserDefaults.standard.synchronize()
    }
}


extension String {
    func localized(bundle: Bundle = .main, tableName: String = "ru") -> String {
        let lang = UserDefaults.standard.string(forKey: "lang") ?? "ru"
        return NSLocalizedString(self, tableName: (lang+"Strings"), value: "**\(self)**", comment: "")
    }
}
