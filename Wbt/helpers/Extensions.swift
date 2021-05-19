//
//  Extensions.swift
//  Wbt
//
//  Created by Hafizullah Samim on 5/2/21.
//

import Foundation
import UIKit
extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1);
    }
    
    convenience init(colorString: String) {
        let valueArray = colorString.components(separatedBy: ":");
        
        if (valueArray.count < 3) {
            self.init(r: 181/255, g: 181/255, b: 181/255);
        } else {
            self.init(red: CGFloat(Float(valueArray[0])!/255.0), green: CGFloat(Float(valueArray[1])!/255.0), blue: CGFloat(Float(valueArray[2])!/255.0), alpha: 1);
        }
    }
}

extension String {
    var localized: String {
        
        var result: String
        
        let languageCode = Locale.preferredLanguage;
        
        var path = Bundle.main.path(forResource: languageCode, ofType: "lproj");
        if path == nil, let index = languageCode.firstIndex(of: "-") {
            let languageCodeShort =  String(languageCode[..<index]);
            path = Bundle.main.path(forResource: languageCodeShort, ofType: "lproj");
        }
        
        if let path = path, let locBundle = Bundle(path: path) {
            result = locBundle.localizedString(forKey: self, value: nil, table: nil);
        } else {
            result = NSLocalizedString(self, comment: "");
        }
        
        return result
    }
    
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func strikeThrough(withColor:UIColor = .darkGray) -> NSAttributedString {
         let attributeString = NSMutableAttributedString(string: self)
         attributeString.addAttribute(
           NSAttributedString.Key.strikethroughStyle,
           value: 1,
           range: NSRange(location: 0, length: attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.strikethroughColor, value: withColor, range: NSMakeRange(0, attributeString.length))
//        attributeString.addAttribute(NSAttributedString.Key.font, value: withFont, range: NSMakeRange(0, attributeString.length))
           return attributeString
    }
}

extension Locale {
    static var preferredLanguage: String {
        get {
            
            return self.preferredLanguages.first ?? LanguageManager.currentLanguage.languageLocalizationCode
            
        }
        set {
            UserDefaults.standard.set([newValue], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
        }
    }
}

extension UserDefaults {
    func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = self.value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }
    
    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        self.set(data, forKey: key)
    }
}

var theView: UIView?
extension UIView {
    
    func animateZoom(direction: ZoomDirection, type: ZoomType, duration: Double = 0.3, scale: CGFloat = 1.4) {
        var cx, cy: CGFloat
        var tr: CGAffineTransform = CGAffineTransform.identity
        
        if (type == .IN) { tr = self.transform.scaledBy(x: scale, y: scale) }
        
        let h: CGFloat = self.frame.size.height;
        let w: CGFloat = self.frame.size.width;
        
        if (type == .IN) {
            switch direction {
            case .LEFT_DOWN:
                cx = w*scale/2
                cy = h-h*scale/2
                break
            case .LEFT_UP:
                cx = w*scale/2
                cy = h*scale/2
                break
            case .RIGHT_UP:
                cx = w-w*scale/2
                cy = h*scale/2
                break
            case .RIGHT_DOWN:
                cx = w-w*scale/2
                cy = h-h*scale/2
                break
            }
        } else {
            cx = w/scale/2
            cy = h/scale/2
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseInOut], animations: {
            self.transform = tr
            self.center = CGPoint(x: cx, y: cy)
        }, completion: { finish in })
    }
    
    func clearConstraints() {
        for subview in self.subviews {
            subview.clearConstraints()
        }
        self.removeConstraints(self.constraints)
    }
    
    
    func addDropShadow(offset: CGSize = CGSize(width: 0, height: -2), color: UIColor = UIColor.black, radius: CGFloat = 4.0, opacity: Float = 0.08) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
    func dropShadow() {
        self.layer.masksToBounds = false
        //        self.layer.cornerRadius = 7;
        self.layer.shadowOffset = CGSize(width: -1, height: 2)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.4
    }
    
    func dropTopSmallShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: -2)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.15
    }
    func dropSmallShadow() {
        self.layer.masksToBounds = false
        //        self.layer.cornerRadius = 7;
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.1
    }
    func dropMdShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: -1, height: 0)
        self.layer.shadowRadius = 2.5
        self.layer.shadowOpacity = 0.2
    }
    func roundCorners(corners:CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
    
    func hideKeyboardOnTap(for_ view: UIView? = nil) {
        if (view == nil){
            theView = self;
        } else {
            theView = view;
        }
        let tap = UITapGestureRecognizer(target: theView, action: #selector(viewTapped));
        tap.cancelsTouchesInView = false;
        theView?.addGestureRecognizer(tap);
        theView?.isUserInteractionEnabled = true;
    }
    
    @objc private func viewTapped(){
        theView!.endEditing(true);
    }
    
    var activityIndicatorTag: Int { return 9427342 }
//    func startActivityIndicator(_ type: Int = 1) {
//        DispatchQueue.main.async {
//            if self.subviews.filter({$0.tag == self.activityIndicatorTag}).first != nil {
//                return;
//            }
//
//            let dimView = UIView();
//            dimView.frame = self.frame;
//            dimView.center = self.center;
//
//            dimView.tag = self.activityIndicatorTag;
//            self.addSubview(dimView)
//
//            let spinnerFrame = CGRect(x: 0, y: 0, width: 90, height: 90);
//            var loaderName = "";
//            if type != 1 {
//                dimView.backgroundColor = Style.transparentBackgroundColor;
//                loaderName = "blink";
//            } else {
//                dimView.backgroundColor = UIColor.black.withAlphaComponent(0.4);
//                loaderName = "dotted_loader";
//            }
//
//            let spinnerView = LOTAnimationView(name: loaderName);
//            spinnerView.loopAnimation = true;
//            spinnerView.frame = spinnerFrame
//            spinnerView.center = self.center;
//            spinnerView.layer.cornerRadius = 6;
//            spinnerView.layer.masksToBounds = true;
//            spinnerView.backgroundColor = .white;
//            dimView.addSubview(spinnerView);
//
//            spinnerView.play{ (finished) in
//                print("Animation Finished!!")
//            }
//        }
//    }
//
//    func stopActivityIndicator() {
//        DispatchQueue.main.async {
//            if let dimView = self.subviews.filter({$0.tag == self.activityIndicatorTag}).first {
//                if let animationView = dimView.subviews.filter({$0.tag == self.activityIndicatorTag}).first as? LOTAnimationView {
//                    animationView.loopAnimation = false;
//                    animationView.stop();
//                }
//                dimView.removeFromSuperview();
//            }
//        }
//    }
//
//
//    var activityIndicatorTag2: Int { return 9427342 }
//    func startActivityIndicator2(_ type: Int = 1) {
//        DispatchQueue.main.async {
//            if self.subviews.filter({$0.tag == self.activityIndicatorTag}).first != nil {
//                return;
//            }
//
//            let dimView = UIView();
//            dimView.frame = self.frame;
//            dimView.center = self.center;
//
//            dimView.tag = self.activityIndicatorTag2;
//            self.addSubview(dimView)
//
//            let spinnerFrame = CGRect(x: 0, y: 0, width: 200, height: 200);
//            var loaderName = "";
//            if type != 1 {
//                dimView.backgroundColor = Style.transparentBackgroundColor;
//                loaderName = "blink";
//            } else {
//                dimView.backgroundColor = UIColor.black.withAlphaComponent(0.4);
//                loaderName = "cart_loader";
//            }
//
//            let spinnerView = LOTAnimationView(name: loaderName);
//            spinnerView.loopAnimation = true;
//            spinnerView.frame = spinnerFrame
//            spinnerView.center = self.center;
//            spinnerView.layer.cornerRadius = 10;
//            spinnerView.layer.masksToBounds = true;
//            spinnerView.backgroundColor = .white;
//            dimView.addSubview(spinnerView);
//
//            spinnerView.play{ (finished) in
//                print("Animation Finished!!")
//            }
//        }
//    }
//
//    func stopActivityIndicator2() {
//        DispatchQueue.main.async {
//            if let dimView = self.subviews.filter({$0.tag == self.activityIndicatorTag2}).first {
//                if let animationView = dimView.subviews.filter({$0.tag == self.activityIndicatorTag2}).first as? LOTAnimationView {
//                    animationView.loopAnimation = false;
//                    animationView.stop();
//                }
//                dimView.removeFromSuperview();
//            }
//        }
//    }
//    func rotate(degrees: CGFloat) {
//
//        let degreesToRadians: (CGFloat) -> CGFloat = { (degrees: CGFloat) in
//            return degrees / 180.0 * CGFloat.pi
//        }
//        self.transform =  CGAffineTransform(rotationAngle: degreesToRadians(degrees))
//
//        // If you like to use layer you can uncomment the following line
//        //layer.transform = CATransform3DMakeRotation(degreesToRadians(degrees), 0.0, 0.0, 1.0)
//    }
//
//    var safeAreaBottom: CGFloat {
//         if #available(iOS 11, *) {
//            if let window = UIApplication.shared.keyWindowInConnectedScenes {
//                return window.safeAreaInsets.bottom
//            }
//         }
//         return 0
//    }
//
//    var safeAreaTop: CGFloat {
//         if #available(iOS 11, *) {
//            if let window = UIApplication.shared.keyWindowInConnectedScenes {
//                return window.safeAreaInsets.top
//            }
//         }
//         return 0
//    }
}

extension UIView{
    var safeAreaBottom: CGFloat {
         if #available(iOS 11, *) {
            if let window = UIApplication.shared.keyWindowInConnectedScenes {
                return window.safeAreaInsets.bottom
            }
         }
         return 0
    }

    var safeAreaTop: CGFloat {
         if #available(iOS 11, *) {
            if let window = UIApplication.shared.keyWindowInConnectedScenes {
                return window.safeAreaInsets.top
            }
         }
         return 0
    }
}

extension UIApplication {
    var keyWindowInConnectedScenes: UIWindow? {
        return windows.first(where: { $0.isKeyWindow })
    }
}
