//
//  LanguageManager.swift
//  Wbt
//
//  Created by Hafizullah Samim on 5/3/21.
//

import Foundation
import UIKit

enum Language: String {
    case dari = "dari"; case english = "english"; case pashto = "pashto";
    
    //    var languageCode: LanguageCode {
    //        get {
    //            switch self {
    //            case .english:
    //                return .englishCode
    //            case .dari:
    //                return .dariCode
    //            case .pashto:
    //                return .pashtoCode
    //            }
    //        }
    //    }
    var languageLocalizationCode: String {
        get {
            switch LanguageManager.currentLanguage {
            case .dari:
                return "fa-AF";
            case .english:
                return "en";
            case .pashto:
                return "ps-AF";
            }
        }
    }
    
    var mapLanguage: String {
        get {
            switch self {
            case .english:
                return "en";
            case .dari:
                return "fa";
            case .pashto:
                return "fa";
            }
        }
    }
    
}

//enum LanguageCode: String {
//    case dariCode = "fa-AF"; case englishCode = "en"; case pashtoCode = "ps-AF"
//
//    var language: Language {
//        get {
//            switch self {
//            case .englishCode:
//                return .english
//            case .dariCode:
//                return .dari
//            case .pashtoCode:
//                return .pashto
//        }
//    }
//}
//}

struct LanguageManager {
    
    static func getCurrentLanguageCode() -> String {
        switch LanguageManager.currentLanguage {
        case .english:
            return "en";
        case .dari:
            return "dr";
        case .pashto:
            return "ps";
        }
    }
    
    //    static func getCurrentLanguageLocalizationCode() -> String {
    //        switch LanguageManager.currentLanguage {
    //        case .dari:
    //            return "fa-AF";
    //        case .english:
    //            return "en";
    //        case .pashto:
    //            return "ps-AF";
    //        default:
    //            return "en";
    //        }
    //    }
    //    static func getLanguageString(languageCode: String) -> String {
    //        switch languageCode {
    //        case "fa-AF":
    //            return "dari";
    //        case "en":
    //            return "english";
    //        case "ps-AF":
    //            return "pashto";
    //        default:
    //            return "dari";
    //        }
    //    }
    
    //    static var currentLanguageCode: LanguageCode {
    //        get {
    //            if let languageCode = UserDefaults.standard.value(forKey: KeyStrings.currentLanguageCode) as? String {
    //                return LanguageCode(rawValue: languageCode)!;
    //            } else {
    //                return LanguageCode.dariCode;
    //            }
    //        }
    //    }
    
    
    static var currentLanguage: Language {
        get {
            if let language = UserDefaults.standard.value(forKey: StringKeys.currentLanguageKey) as? String {
                return Language(rawValue: language)!;
            } else {
                return Language.dari;
            }
        }
        
        set {
            print("current language: ", newValue.rawValue);
            UserDefaults.standard.setValue(newValue.rawValue, forKey: StringKeys.currentLanguageKey);
            Locale.preferredLanguage = newValue.languageLocalizationCode;
            if newValue == .english {
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
            } else {
                UIView.appearance().semanticContentAttribute = .forceRightToLeft;
            }
        }
    }
    static var isLanguageSelected:Bool{
        get{
            if let isSelected = UserDefaults.standard.value(forKey: "isLangSelected") as? Bool{
                return isSelected
            }else{
                return false
            }
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: "isLangSelected")
        }
    }
}
