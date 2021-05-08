//
//  Theme.swift
//  Wbt
//
//  Created by Hafizullah Samim on 5/2/21.
//

import Foundation
import UIKit
enum Theme: String {
    case default_ = "default";
    case light_ = "light";
    
    static var currentTheme: Theme {
        get {
            if UserDefaults.standard.value(forKey: StringKeys.currentThemeKey) != nil {
                return Theme(rawValue: UserDefaults.standard.value(forKey: StringKeys.currentThemeKey) as! String)!
            } else {
                return Theme.default_
            }
        }
        set {
            Style.setupTheme(theme: newValue);
        }
    }
}

struct Style {
    
    private static let boldFont = "BahijHelveticaNeue75Bold";
    private static let regularFont = "BahijHelveticaNeue" // Bahij;
    private static let thinFont = "BahijHelveticaNeue";
    private static let lightFont = "BahijHelveticaNeue";
    private static let mediumFont = "BahijHelveticaNeue";
    
    
    static var colorPrimary:UIColor!
    static var colorPrimaryExtraLight:UIColor!
    static var colorPrimaryLight:UIColor!
    static var colorPrimaryDark:UIColor!
    static var colorPrimaryExtraDark:UIColor!
    static var colorTextPrimary:UIColor!
    static var colorTextGray:UIColor!
    static var colorTextLink:UIColor!
    
    // ======= Fonts =============
    static var titleNormalFont:UIFont!
    static var titleSmNormalFont:UIFont!
    static var titleSmBoldFont:UIFont!
    static var titleBoldFont:UIFont!
    static var smallFont: UIFont!
    static var smallBoldFont: UIFont!
    static var normalFont: UIFont!
    static var normalBoldFont: UIFont!
    static var bigFont: UIFont!
    static var bigBoldFont: UIFont!
    static var smallerFont: UIFont!
    static var smallerBoldFont: UIFont!
    static var extraLargeFont: UIFont!
    static var veryBigFont: UIFont!
    static var miniFont: UIFont!
    static var biggerFont: UIFont!
    static var biggerBoldFont: UIFont!
    static func setupTheme(theme: Theme){
        UserDefaults.standard.setValue(theme.rawValue, forKey: StringKeys.currentThemeKey);
        switch theme {
        case .default_:
            setupDefaultTheme();
        case .light_:
            setupLightTheme()
        }
    }
    
    private static func setupDefaultTheme(){
        self.colorPrimaryExtraLight = UIColor(r: 98, g: 98, b: 181)
        self.colorPrimaryLight = UIColor(r: 64, g: 64, b: 115)
        self.colorPrimary = UIColor(r: 50, g: 50, b: 89)
        self.colorPrimaryDark = UIColor(r: 27, g: 27, b: 56)
        self.colorPrimaryExtraDark = UIColor(r: 14, g: 14, b: 33)
        
        self.colorTextPrimary = UIColor.white
        self.colorTextGray = UIColor.gray
        self.colorTextLink = UIColor.blue
        
        // -------- Fonts ----------------
        titleNormalFont = UIFont(name: regularFont, size: 36)
        titleBoldFont = UIFont(name: boldFont, size: 36)
        titleSmNormalFont = UIFont(name: regularFont, size: 23)
        titleSmBoldFont = UIFont(name: boldFont, size: 23)
        smallFont = UIFont(name: regularFont, size: 14)
        smallBoldFont = UIFont(name: boldFont, size: 14);
        smallerFont = UIFont(name: regularFont, size: 11);
        smallerBoldFont = UIFont(name: boldFont, size: 11);
        normalFont = UIFont(name: regularFont, size: 18);
        normalBoldFont = UIFont(name: boldFont, size: 18);
        bigFont = UIFont(name: regularFont, size: 20);
        bigBoldFont = UIFont(name: boldFont, size: 20);
        
        extraLargeFont = UIFont(name: regularFont, size: 36);
        veryBigFont = UIFont(name: regularFont, size: 26);
        
        
        
        
        miniFont = UIFont(name: regularFont, size: 7);
        biggerFont = UIFont(name: regularFont, size: 26);
        biggerBoldFont = UIFont(name: boldFont, size: 26);
    }
    
    private static func setupLightTheme(){
        
    }
}
