//
//  SystemUtility.swift
//  Brandi
//
//  Created by Ryan on 2016. 1. 25..
//  Copyright © 2016년 Brandi. All rights reserved.
//

import Foundation
#if !os(watchOS)
import WebKit
#endif

public enum LocaleType: String {
    case eng = "en"
    case kor = "ko"
    case ELSE = "other language"
}

public enum DeviceType: CGFloat {
    case iPhone4 = 567.0
    case iPhone5 = 568.0
    case iPhone6 = 667.0
    case iPhone6P = 736.0
    case iPhoneX = 812.0
    case iPhone12 = 844
    case iPhoneXSM = 896.0  // iPhone Xr has the same logical resolution with iPhone Xs Max
    case iPhone12M = 926
    case notRecognized = 0.0
}

open class SystemUtility {
    // MARK: Variables
    private static var keySet: [NSValue] = []
    private static var titleSet: [NSValue: String?] = [ : ]
    private static var refreshSet: [NSValue: Bool] = [ : ]
    private static var loginRefreshSet: [NSValue: Bool] = [ : ]
    
    // MARK: Constants
    public static let DURATION_ANIMATION: TimeInterval = 0.3
    
    // MARK: System Status Functions
    public static func getBrandiBuildVersion() -> String {
        var ver: String = "0"
        if let version = Bundle.main.infoDictionary?[String(kCFBundleVersionKey)] as? String {
            ver = version
            Logger.infoLog("Brandi iOS version is: \(ver)")
//            BRFirebaseCrashlytics.writeCrashLog(string: "\(#function):: Brandi iOS version is: \(ver)")
        } else {
            Logger.infoLog("An Error Occurered within getting app version process")
//            BRFirebaseCrashlytics.writeCrashLog(string: "\(#function):: An Error Occurered within getting app version process")
        }
        return ver
    }
    
    public static func getBrandiVersionCode() -> String {
        var ver: String = "0.0.0"
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            ver = version
            Logger.infoLog("Brandi iOS version is: \(ver)")
//            BRFirebaseCrashlytics.writeCrashLog(string: "\(#function):: Brandi iOS version is: \(ver)")
        } else {
            Logger.infoLog("An Error Occurered within getting app version process")
//            BRFirebaseCrashlytics.writeCrashLog(string: "\(#function):: An Error Occurered within getting app version process")
        }
        return ver
    }
    
    public static func getLocale() -> LocaleType {
        guard let language = Locale.preferredLanguages.first else { return LocaleType.kor }
        if language.contains(LocaleType.kor.rawValue) {
            return LocaleType.kor
        } else if language.contains(LocaleType.eng.rawValue) {
            return LocaleType.eng
        } else {
            return LocaleType.ELSE
        }
    }
    
    public static func screenSizeRect() -> CGRect {
        return UIScreen.main.bounds
    }
    
    public static func getDeviceType() -> DeviceType {
        let height = UIScreen.main.bounds.height
        if height < DeviceType.iPhone5.rawValue {
            Logger.infoLog("IPHONE_4")
            return .iPhone4
        } else if height == DeviceType.iPhone5.rawValue {
            Logger.infoLog("IPHONE_5")
            return .iPhone5
        } else if height == DeviceType.iPhone6.rawValue {
            Logger.infoLog("IPHONE_6")
            return .iPhone6
        } else if height == DeviceType.iPhone6P.rawValue {
            Logger.infoLog("IPHONE_6P")
            return .iPhone6P
        } else if height == DeviceType.iPhoneX.rawValue {
            Logger.infoLog("IPHONE_X")
            return .iPhoneX
        } else if height == DeviceType.iPhone12.rawValue {
            Logger.infoLog("IPHONE_12")
            return .iPhone12
        } else if height == DeviceType.iPhoneXSM.rawValue {
            Logger.infoLog("IPHONE_XSM")
            return .iPhoneXSM
        } else if height == DeviceType.iPhone12M.rawValue {
            Logger.infoLog("IPHONE_12M")
            return .iPhone12M
        } else {
            Logger.infoLog("IOS_DEVICE_TYPE_NOT_REQUIRED")
            return .notRecognized
        }
    }
    
    public static func getDeviceNameInDetail() -> String {
        var modelName: String {
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            let identifier = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
            
            switch identifier {
            case "iPod5,1":                                 return "iPod Touch 5"
            case "iPod7,1":                                 return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad Pro"
            case "AppleTV5,3":                              return "Apple TV"
            case "i386", "x86_64":                          return "Simulator"
            default:                                        return identifier
            }
        }
        return modelName
    }
    /*
    static func saveStatusOf(_ viewController: SuperViewController) {
        let key = NSValue.init(nonretainedObject: viewController)
        let title = viewController.navigationItem.title
        self.titleSet[key] = title
        self.refreshSet[key] = false
        self.loginRefreshSet[key] = false
        if !self.keySet.contains(key) {
            self.keySet.append(key)
        }
        Logger.infoLog("saved Title: \(String(describing: title))")
    }
    
    static func loadStatusOf(_ viewController: SuperViewController) {
        let key = NSValue.init(nonretainedObject: viewController)
        let title = self.titleSet[key]
        let refresh = self.refreshSet[key]
        let loginRefresh = self.loginRefreshSet[key]
        if title != nil && title! != nil {
            viewController.setNavigationTitle(title!!)
        } else {
            viewController.setNavigationTitle("")
        }
        viewController.haveToRefresh = (refresh != nil) ? refresh! : false
        viewController.refreshForLogin = (loginRefresh != nil) ? loginRefresh! : false
        Logger.infoLog("loaded Title: \(String(describing: title))")
    }
    
    static func refreshAllViewControllers() {
        for key in keySet {
            self.refreshSet[key] = true
        }
    }
    
    static func refreshAllViewControllersForLogin() {
        for key in self.keySet {
            self.loginRefreshSet[key] = true
        }
    }*/
    
    // MARK: System Management Functions
    public static func startDelayedTask(_ duration: Double, taskBlock: @escaping (() -> Void)) {
        let delay = duration * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time,
                       execute: {
                        taskBlock()
            }
        )
    }
    
    public static func setApplicationBadgeNumber(_ number: Int) {
        UIApplication.shared.applicationIconBadgeNumber = number
    }
    /*
    static func logoutFromService() {
        DBDataStore.database().bookmarks().deleteAllSellerBookmark()
        DBDataStore.database().bookmarkProduct().deleteAllBookmarkProduct()
        DBDataStore.database().bookmarkProductRealm().deleteAll()
        TempOrderShippingDataManager.getManager().resetTempOrderShippingData()
        BROrderTempDataManager.shared.removeAllData()
        BREventTracker.resetGenerateSessionId()
        ReviewFilterManager.resetAllFilters()
        CoreDataStore.removeSession(completion: { complete in
            self.setApplicationBadgeNumber(0)
            if let gvc = self.getTopWindow()?.rootViewController as? BRGateWayViewController {
                gvc.dismiss(animated: true, completion: nil)
                gvc.eventHandler?.startInitializeProcess()
            }
        })
    }
    
    static func logoutFromServiceWithOutGoingGateWay() {
        DBDataStore.database().bookmarks().deleteAllSellerBookmark()
        DBDataStore.database().bookmarkProduct().deleteAllBookmarkProduct()
        DBDataStore.database().bookmarkProductRealm().deleteAll()
        TempOrderShippingDataManager.getManager().resetTempOrderShippingData()
        BROrderTempDataManager.shared.removeAllData()
        BREventTracker.resetGenerateSessionId()
        ReviewFilterManager.resetAllFilters()
        CoreDataStore.removeSession(completion: nil)
    }*/
    
    public static func getTopWindow() -> UIWindow? {
        if let window = UIApplication.shared.delegate?.window {
            return window
        } else {
            return nil
        }
    }
    
    public static func getTopViewController() -> UIViewController? {
        if let baseController = UIApplication.shared.delegate?.window??.visibleViewController {            
            if baseController.isKind(of: UITabBarController.self) {
                // navigationController의 CurrentViewController를 리턴
                let tab = (baseController as! UITabBarController)
                let nav = tab.selectedViewController as? UINavigationController
                if let vc = nav?.presentedViewController {
                    return vc
                }
            } else if baseController.isKind(of: UINavigationController.self) {
                // CurrentViewController 를 리턴
                let nav = baseController as? UINavigationController
                if let vc = nav?.presentedViewController {
                    return vc
                }
            } else if baseController.isKind(of: UIViewController.self) {
                // 리턴
                return baseController
            }
        }
        return nil
    }
    
    /*
    // MARK: Global NavigationController Related Functions
    static func setGlobalNavigationControllerOptions(_ controller: UINavigationController) {
        self.setGlobalNavigationControllerOptions(controller.navigationBar, animated: false)
    }
    
    static func setGlobalNavigationControllerOptions(_ controller: UINavigationController, animated: Bool) {
        self.setGlobalNavigationControllerOptions(controller.navigationBar, animated: animated)
    }
    
    static func setGlobalNavigationControllerOptions(_ navigationBar: UINavigationBar) {
        self.setGlobalNavigationControllerOptions(navigationBar, animated: false)
    }
    
    static func setPrimaryNavigationControllerOptions(_ controller: UINavigationController) {
        self.setPrimaryNavigationControllerOptions(controller, animated: false)
    }
    
    static func setGlobalNavigationControllerOptions(_ navigationBar: UINavigationBar, animated: Bool) {
        self.setGlobalNavigationControllerOptions(navigationBar, color: ResourceDataStore.colors().COLOR_BRANDI_FFFFFF, transparent: false, animated: animated)
    }
    
    static func setPrimaryNavigationControllerOptions(_ controller: UINavigationController, animated: Bool) {
        self.setGlobalNavigationControllerOptions(controller.navigationBar, color: ResourceDataStore.colors().COLOR_BRANDI_FFFFFF, transparent: false, animated: animated)
    }
    
    static func setGlobalNavigationControllerOptions(_ navigationBar: UINavigationBar, color: UIColor, transparent: Bool, animated: Bool) {
        let backImage = Asset.Assets.icoBack.image.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8))
        let backImageSel = Asset.Assets.icoBack.image.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8))
        navigationBar.backIndicatorImage = backImage
        navigationBar.backIndicatorTransitionMaskImage = backImageSel
        var duration: TimeInterval?
        if animated {
            duration = self.DURATION_ANIMATION
        } else {
            duration = 0.0
        }
        UIView.animate(withDuration: duration!, animations:
            {
                navigationBar.barTintColor = color
                navigationBar.tintColor = UIColor.black
                navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
                navigationBar.isTranslucent = transparent
                navigationBar.barStyle = .default
            }
        )
    }
    
    static let navBorder = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    static func setBWColorNavigationControllerOptions(_ navigationBar: UINavigationBar, isInversed: Bool, animated: Bool) {
        let backImage = Asset.Assets.icoBack.image.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8))
        let backImageSel = Asset.Assets.icoBack.image.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8))
        self.navBorder.frame = CGRect(x: 0, y: navigationBar.frame.size.height, width: navigationBar.frame.size.width, height: 0.4)
        self.navBorder.backgroundColor = ResourceDataStore.colors().COLOR_BRANDI_4D4D4D
        self.navBorder.isOpaque = true
        if !isInversed {
            navigationBar.backIndicatorImage = backImage
            navigationBar.backIndicatorTransitionMaskImage = backImageSel
            self.navBorder.removeFromSuperview()
        } else {
            navigationBar.backIndicatorImage = backImageSel
            navigationBar.backIndicatorTransitionMaskImage = backImage
            if !navigationBar.subviews.contains(self.navBorder) {
                navigationBar.addSubview(self.navBorder)
            }
        }
        var duration: TimeInterval?
        if animated {
            duration = self.DURATION_ANIMATION
        } else {
            duration = 0.0
        }
        UIView.animate(withDuration: duration!, animations:
            {
                navigationBar.barTintColor = (isInversed) ? ResourceDataStore.colors().COLOR_BRANDI_202020 : UIColor.white
                navigationBar.tintColor = (isInversed) ? UIColor.white : ResourceDataStore.colors().COLOR_BRANDI_202020
                navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: (isInversed) ? UIColor.white : ResourceDataStore.colors().COLOR_BRANDI_202020]
                navigationBar.isTranslucent = false
                navigationBar.barStyle = .default
            }
        )
    }
    
    // MARK: Global Popup Related Functions
    static func showGlobalMaintenancePopup(_ data: MaintenanceModel) {
        let title = ResourceDataStore.strings().STRING_ALERT_SERVER_MAINTENANCE
        let contentString = ResourceDataStore.strings().STRING_ALERT_SERVER_MAINTENANCE_CONTENT
        let dateString = StringUtility.getMaintenanceStringFrom(data)
        let maintenanceView = UIStoryboard(name: ResourceDataStore.identifiers().STORYBOARD_IDENTIFIER_MAINTENANCE, bundle: nil).instantiateViewController(withIdentifier: ResourceDataStore.identifiers().VIEWCONTROLLER_IDENTIFIER_MAINTENANCE) as! BRGlobalMaintenanceView
        maintenanceView.titleString = title
        maintenanceView.contentString = contentString
        maintenanceView.descriptionString = dateString
        maintenanceView.view.alpha = 0.0
        if let window = self.getTopWindow() {
            maintenanceView.view.frame = CGRect(x: 0, y: 0, width: window.frame.size.width, height: window.frame.size.height)
        }
        maintenanceView.buttonClose.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeApplication)))
//        self.getTopWindow()?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeApplication)))
        self.getTopWindow()?.addSubview(maintenanceView.view)
        self.getTopWindow()?.rootViewController?.addChild(maintenanceView)
        UIView.animate(withDuration: 0.2, animations:
            {
                maintenanceView.view.alpha = 1.0
            }
        )
    }
    
    static func showGlobalGuestUserLoginPopup() {
        self.hideLoadingView(
            { complete in
                if complete {
                    self.showLoginViewController()
//                    let message = ResourceDataStore.strings().STRING_ALERT_USER_IS_GUEST_MESSAGE
//                    let login = UIAlertAction(title: ResourceDataStore.strings().STRING_ALERT_USER_IS_GUEST_CONFIRM, style: .Default, handler:
//                        { alert in
//                            self.showLoginViewController()
//                        }
//                    )
//                    if let rootViewController = self.getTopWindow()?.visibleViewController {
//                        AlertUtility.showGeneralAlertWithCustomButtons(rootViewController, title: nil, message: message, actions: [login], addCancelButton: true, style: .Alert, cofirmationHandler: nil)
//                    }
                }
            }
        )
    }
    
    static func showLoginViewController() {
        if let rootViewController = self.getTopWindow()?.visibleViewController {
            Coordinator.Login(source: rootViewController)
                .destination(.login(backButtonType: .rightCloseToRoot, isFromSignUpView: false, isPresentingNew: true))
                .destination(options: .wrapping(), .modalPresentationStyle(.fullScreen))
                .present()
        }
    }
    
    static func showGlobalGuestUserSignUpPopup() {
        self.hideLoadingView(
            { complete in
                if complete {
                    self.showSignUpHomeViewController()
                }
            }
        )
    }
    
    static func showSignUpHomeViewController() {
        if let rootViewController = self.getTopWindow()?.visibleViewController {
            let wireframe = BRSignUpHomeWireframe()
            wireframe.rootViewControllerPlaceholder = rootViewController
            wireframe.presentViewController(true, isPresentingNew: true)
        }
    }*/
    
    public static func killApplicationImmediately() {
        exit(0)
    }
    
//    @objc private static func closeApplication(_ sender: UITapGestureRecognizer) {
//        exit(0)
//    }

    /*
    private static var isInDisplay: Bool = false //디스플레이중인지 판별
    private static let TAG_MESSAGEVIEW: Int = 484773321
    static func showGlobalNotificationMessagePopup(_ title: String, textColor: UIColor, bgColor: UIColor) {
        if let rootWindow = self.getTopWindow() {
            if self.isInDisplay {
                for subView in rootWindow.subviews {
                    if subView.tag == self.TAG_MESSAGEVIEW {
                        subView.removeFromSuperview()
                    }
                }
            }
            if let viewController = rootWindow.rootViewController {
                self.isInDisplay = true
                let DELAY_DISMISS: Double = 2.5
                let POSITION_Y: CGFloat = 150
                let MARGIN: CGFloat = 8.0
                var WIDTH: CGFloat = 375.0
                var HEIGHT: CGFloat = 28
                if let width = self.getTopWindow()?.frame.size.width {
                    WIDTH = width - (MARGIN * 4)
                }
                let labelSize = ResourceDataStore.dimensions().DIMENSION_SIZE_FROM_CHARACTER_LENGTH(title, textSize: 13)
                let changeWidth = labelSize.width
                if changeWidth < WIDTH {
                    WIDTH = changeWidth
                }
                let size = CGSize(width: WIDTH, height: 10000)
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: WIDTH + (MARGIN * 2), height: size.height))
                label.numberOfLines = 0
                label.lineBreakMode = .byWordWrapping
                label.text = title
                label.sizeToFit()
                if label.frame.size.height > HEIGHT {
                    HEIGHT = label.frame.size.height + MARGIN
                }
                let frame = CGRect(x: 0, y: 0, width: WIDTH + (MARGIN * 2), height: HEIGHT)
                let messageView = BRGlobalNotification.makeViewFromNib(frame)
                messageView.tag = self.TAG_MESSAGEVIEW
                messageView.backgroundColor = bgColor
                messageView.center = CGPoint(x: viewController.view.center.x, y: POSITION_Y + label.frame.size.height / 2)
                self.startDelayedTask(DELAY_DISMISS, taskBlock:
                    {
                        UIView.animate(withDuration: DURATION_ANIMATION, animations:
                            {
                                messageView.alpha = 0.0
                            }
                            , completion:
                            { complete in
                                if complete {                                    
                                    messageView.removeFromSuperview()
                                    self.isInDisplay = false
                                }
                            }
                        )
                    }
                )
                messageView.labelText.lineBreakMode = .byWordWrapping
                messageView.labelText.text = title
                messageView.labelText.textColor = textColor
                messageView.alpha = 0.0
                rootWindow.addSubview(messageView)
                UIView.animate(withDuration: DURATION_ANIMATION, animations:
                    {
                        messageView.alpha = 1.0
                    }
                )
            }
        }
    }
    
    static func showGlobalNotificationMessagePopup(_ title: String, bgColor: UIColor) {
        self.showGlobalNotificationMessagePopup(title, textColor: UIColor.white, bgColor: bgColor)
    }
    
    static func showGlobalNotificationMessagePopup(_ title: String) {
        self.showGlobalNotificationMessagePopup(title, textColor: UIColor.white, bgColor: ResourceDataStore.colors().COLOR_BRANDI_4C4C4C)
    }
    
    // MARK: Loading progress view related functions
    private static var loadingView: BRLoadingProgressView?
    
    static func getLoadingView() -> BRLoadingProgressView? {
        return self.loadingView
    }
    
    static func showLoadingView(_ text: String?, dismissDelay: Double?) {
        if let rootWindow = self.getTopWindow() {
            if self.loadingView == nil {
                self.loadingView = BRLoadingProgressView.makeViewFromNib(CGRect.zero)
            } else {
                self.loadingView?.alpha = 0.0
                self.loadingView?.isHidden = true
            }
            if rootWindow.subviews.contains(self.loadingView!) {
                rootWindow.bringSubviewToFront(self.loadingView!)
            } else {
                rootWindow.addSubview(self.loadingView!)
            }
            let frameLoading = CGRect(x: 0, y: 0, width: (rootWindow.frame.size.width), height: (rootWindow.frame.size.height))
            self.loadingView?.frame = frameLoading
            self.loadingView?.isHidden = false
            self.loadingView?.isUserInteractionEnabled = true
            self.loadingView?.labelLoading.text = text
            self.loadingView?.setImageView()
            let loadingViewDuration: TimeInterval = 0
            UIView.animate(withDuration: loadingViewDuration, animations:
                {
                    self.loadingView?.alpha = 1.0
                }
            )
            if let delay = dismissDelay {
                self.startDelayedTask(delay, taskBlock:
                    {
                        hideLoadingView(nil)
                    }
                )
            }
        }
    }
    
    static func hideLoadingView(_ completionHandler: ((Bool) -> Void)?) {
        let loadingViewDuration: TimeInterval = 0.3
        if let loadingView = self.loadingView {
            UIView.animate(withDuration: loadingViewDuration, animations:
                {
                    loadingView.alpha = 0.0
                },
                                       completion:
                { complete in
                    completionHandler?(complete)
                }
            )
        } else {
            completionHandler?(true)
        }
    }
    
    static func setLoadingViewtitle(_ text: String?, dismissDelay: Double?) {
        if let loadingView = self.loadingView {
            DispatchQueue.main.async(execute: {
                            loadingView.labelLoading.text = text
                }
            )
            if let dismiss = dismissDelay {
                self.startDelayedTask(dismiss, taskBlock:
                    {
                        self.hideLoadingView(nil)
                    }
                )
            }
        } else {
            self.showLoadingView(text, dismissDelay: dismissDelay)
        }
    }*/
    
    // MARK: Blurry Fullscreen Page Functions
    private static var viewBlurry: UIView?
    public static func showBlurryViewOnTopWindow() {
        if let rootWindow = UIApplication.shared.keyWindow {
            if self.viewBlurry == nil {
                self.viewBlurry = GUIUtility.getBlurEffectView()
            }
            self.viewBlurry?.alpha = 0.0
            self.viewBlurry?.isHidden = true
            if rootWindow.subviews.contains(self.viewBlurry!) {
                rootWindow.bringSubviewToFront(self.viewBlurry!)
            } else {
                rootWindow.addSubview(self.viewBlurry!)
            }
            let frameLoading = CGRect(x: 0, y: 0, width: (rootWindow.frame.size.width), height: (rootWindow.frame.size.height))
            self.viewBlurry?.frame = frameLoading
            //            self.loadingView?.viewBlurryBackground.frame = frameLoading
            self.viewBlurry?.isHidden = false
            self.viewBlurry?.isUserInteractionEnabled = true
            UIView.animate(withDuration: self.DURATION_ANIMATION, animations:
                {
                    self.viewBlurry?.alpha = 1.0
                }
            )
        }
    }
    
    public static func hideBlurryViewFromTopWindow(_ completionHandler: ((Bool) -> Void)?) {
        if let blurry = self.viewBlurry {
            UIView.animate(withDuration: self.DURATION_ANIMATION, animations:
                {
                    blurry.alpha = 0.0
                },
                                       completion:
                { complete in
                    completionHandler?(complete)
                }
            )
        }
    }
    
    /*
    static func showGlobalImagePopup(image: ImagePopup) {
        // distinguish logic
        let repeatCycle: Int = image.repeat_cylcle_minutes
        var compareTime: Int = 0
        guard let id = image.id else { return }
        if let data = CoreDataStore.getSession().imagePopups {
            if let time = data[id] {
                compareTime = time
            }
        }
        if let currentTime = Int(StringUtility.getCurrentTimeStamp()) {
            let currentMinute: Int = currentTime / 60
            if ((compareTime + repeatCycle) < currentMinute) || repeatCycle == 0 {
                // show popup
                if let urlString = image.image_url, let url = URL(string: urlString) {
                    NetworkUtility.getDataFromUrl(url, completion:
                        { data, response, error in
                            if error == nil && data != nil {
                                let imageUI = UIImage(data: data!)
                                let reformed = imageUI!.pngData()
                                let imageReformed = UIImage(data: reformed!)
                                var vc: UIViewController?
                                if let control = SystemUtility.getTopViewController() {
                                    vc = control
                                } else if let window = SystemUtility.getTopWindow() {
                                    vc = window.visibleViewController
                                }
                                if let vcc = vc {
                                    let popup = BRSystemPopupViewController.getViewControllerFromStoryboard()
                                    popup?.image = imageReformed
                                    popup?.stringButtonText = ResourceDataStore.strings().STRING_CONFIRM
                                    popup?.modalPresentationStyle = .overCurrentContext
                                    if let tabBar = vcc.tabBarController {
                                        var activated = false
                                        if let v = tabBar.presentingViewController?.isKind(of: BRSystemPopupViewController.self) {
                                            activated = v
                                        }
                                        if tabBar.isKind(of: BRSystemPopupViewController.self) {
                                            activated = true
                                        }
                                        if !activated {
                                            SystemUtility.hideLoadingView(nil)
                                            tabBar.present(popup!, animated: true, completion: nil)
                                        }
                                    } else {
                                        var activated = false
                                        if let v = vcc.presentingViewController?.isKind(of: BRSystemPopupViewController.self) {
                                            activated = v
                                        }
                                        if vcc.isKind(of: BRSystemPopupViewController.self) {
                                            activated = true
                                        }
                                        if !activated {
                                            SystemUtility.hideLoadingView(nil)
                                            vcc.present(popup!, animated: true, completion: nil)
                                        }
                                    }
                                    if repeatCycle == -1 {
                                        CoreDataStore.getSession().imagePopups = [id: Int.max]
                                    } else {
                                        CoreDataStore.getSession().imagePopups = [id: currentMinute]
                                    }
                                }
                            }
                    }
                    )
                }
            }
        }
    }*/
    
    #if !os(watchOS)
    private static var globalWKWebView: WKWebView?
    
    public static func getGlobalWKWebView(_ frame: CGRect) -> WKWebView {
        self.globalWKWebView?.removeFromSuperview()
        if self.globalWKWebView == nil {
            let config = WKWebViewConfiguration()
            config.allowsInlineMediaPlayback = true
            config.dataDetectorTypes = []
            self.globalWKWebView = WKWebView(frame: frame, configuration: config)
        }
        self.globalWKWebView?.frame = frame
        self.globalWKWebView?.layoutIfNeeded()
        return self.globalWKWebView!
    }
    
    public static func setGlobalWKWebViewReleased() {
        self.globalWKWebView = nil
    }
    
    public static func isGlobalWKWebViewNil() -> Bool {
        return (self.globalWKWebView == nil) ? true : false
    }
    #endif
    
    public static func saveV2Popup(_ needed: Bool, title: String, content: String) {
        self.v2PopupNeeded = needed
        self.v2PopupTitle = title
        self.v2PopupContent = content
    }
    
    private static var v2PopupNeeded = false
    private static var v2PopupTitle: String?
    private static var v2PopupContent: String?
    public static func getV2Popup() -> (title: String, content: String)? {
        if self.v2PopupNeeded && self.v2PopupTitle != nil && self.v2PopupContent != nil {
            self.v2PopupNeeded = false
            return (title: self.v2PopupTitle!, content: self.v2PopupContent!)
        } else {
            return nil
        }
    }
    
    private static var alertPushPopupNeeded = false
    public static func getAlertPushPopup() -> Bool {
        if self.alertPushPopupNeeded {
//            self.alertPushPopupNeeded = false
            return true
        } else {
            return false
        }
    }
    
    public static func setAlertPushPopup(_ alertPushPopupNeeded: Bool) {
        self.alertPushPopupNeeded = alertPushPopupNeeded
    }
    
//    private static var hasCompletedPhraseData: Bool = false
//    private static var signUpCompletedPhrase: CompletedPhraseData?
//    static func getHasCompletedPhraseData() -> Bool {
//        return self.hasCompletedPhraseData
//    }
//
//    static func setHasCompletedPhraseData(_ hasCompletedPhrase: Bool) {
//        self.hasCompletedPhraseData = hasCompletedPhrase
//    }
//
//    static func getSignUpCompletedPhrase() -> CompletedPhraseData? {
//        return self.signUpCompletedPhrase
//    }
//    
//    static func setSignUpCompletedPhrase(_ signUpCompletedPhraseData: CompletedPhraseData) {
//        if !self.hasCompletedPhraseData {
//            self.signUpCompletedPhrase = signUpCompletedPhraseData
//            self.hasCompletedPhraseData = true
//        }
//    }
}
