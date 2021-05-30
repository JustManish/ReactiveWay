//
//  UIViewControllerExtension.swift
//  jaldilive
//
//  Created by iSHU on 07/09/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

struct JLActionSheetButton {
    var title: String!
    var type: UIAlertAction.Style!
}

extension UIViewController {
    func presentAlert(withTitle title: String, andMessage message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func presentAlert(withTitle title: String?, message: String?, buttons: [JLActionSheetButton],
                      completion: @escaping ((Int) -> Void)) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
            
            // Add Buttons to alert controller
            var i = 0
            for button in buttons {
                let j = i
                let action = UIAlertAction(title: button.title,
                                           style: button.type,
                                           handler:
                    { (action) in
                        completion(j)
                })
                
                alert.addAction(action)
                i += 1
            }
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func deviceAuthAlert(withTitle title: String, andMessage message: String,controller:UIViewController) {
        
    }
    
    func showToast(message : String, spaceBottom: CGFloat? = 60, duration: CGFloat? = 5.0) {
        DispatchQueue.main.async
            {
            let toastLabel = UILabel(frame: CGRect(x:20, y: self.view.frame.size.height - (spaceBottom ?? 60), width:self.view.frame.size.width-40, height: 50))
                toastLabel.backgroundColor = UIColor.black
                toastLabel.textColor = UIColor.white
                toastLabel.font = UIFont(name: "FredokaOne-Regular", size: 14.0)
                toastLabel.textAlignment = .center;
                toastLabel.text = message
                toastLabel.numberOfLines = 0
                toastLabel.alpha = 1.0
                toastLabel.layer.cornerRadius = 10;
                toastLabel.clipsToBounds  =  true
                self.view.addSubview(toastLabel)
            UIView.animate(withDuration: TimeInterval(duration ?? 5.0), delay: 0.2, options: .curveEaseOut, animations: {
                    toastLabel.alpha = 0.0
                }, completion: {(isCompleted) in
                    toastLabel.removeFromSuperview()
                })
        }
    }
    
    var top: UIViewController? {
        if let controller = self as? UINavigationController {
            return controller.topViewController?.top
        }
        if let controller = self as? UISplitViewController {
            return controller.viewControllers.last?.top
        }
        if let controller = self as? UITabBarController {
            return controller.selectedViewController?.top
        }
        if let controller = presentedViewController {
            return controller.top
        }
        return self
    }
    
//    func notificationHandle(){
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "User", bundle: nil)
//        let VC = mainStoryboard.instantiateViewController(withIdentifier: "TransactionsViewController") as! TransactionsViewController
//        self.navigationController?.pushViewController(VC, animated: false)
//        
//    }
    /*
    func presentLiveFeedScreen(liveStreamId:String) {
        let application = UIApplication.shared
        NetworkManager().getDeepLinkLiveStremData(liveStremId: liveStreamId, onController: self) { (liveStreamData) in
            if let status = liveStreamData.status, status {
                DispatchQueue.main.async {
                    guard let topVC = application.windows.first?.rootViewController else {return}
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    if let feedContainerVC = mainStoryboard.instantiateViewController(identifier: "FeedContainerViewController") as? FeedContainerViewController {
                       
                        let jsonEncoder = JSONEncoder()
                        do {
                            
                            let liveStreamInfo = liveStreamData.success?.data?.first
                            let jsonData = try jsonEncoder.encode(liveStreamInfo)
                            UserDefaults.standard.setValue(jsonData, forKey: "deeplink_liveStreamInfo")
                            UserDefaults.standard.synchronize()
                        }
                        catch let error  {
                            // self.presentAlert(withTitle: "Error", andMessage: error.localizedDescription)
                        }
                       
                        let newData = UserDefaults.standard.data(forKey: "deeplink_liveStreamInfo") ?? Data()
                          if !newData.isEmpty {
                            do {
                               if let liveData = Network().decodeJSON(withClass: DiscoveryStreamLiveStreamInfo.self, fromData: newData, onController: topVC) {
                                    print("liveData:---\(liveData)")
                                    var liveDatum = DiscoveryStreamDatum()
                                    liveDatum.liveStreamInfo = liveData
                                    feedContainerVC.selectedIndex = 0
                                    feedContainerVC.liveStreamViewModel.liveStreamData.accept([liveDatum])
                                    feedContainerVC.modalPresentationStyle = .overCurrentContext
                               
                                UserDefaults.standard.setValue(nil, forKey: "deeplink_liveStreamInfo")
                                     
                                self.present(feedContainerVC, animated: true, completion: nil)
                                }
                            } catch let error {
                                print("error - ", error)
                                topVC.presentAlert(withTitle: "Error", andMessage: error.localizedDescription)
                            }
                        }
                    }
                }
            }else {
                self.presentAlert(withTitle: "Error", andMessage: liveStreamData.error?.message ?? VariablesConstants.notAvailableString)
            }
        }
    }*/
    
}

//extension UIApplication {
//    class func topViewController(base: UIViewController? = UIApplication.shared.windows.last?.rootViewController) -> UIViewController? {
//
//        if let nav = base as? UINavigationController {
//            return topViewController(base: nav.visibleViewController)
//        }
//
//        if let tab = base as? UITabBarController {
//            let moreNavigationController = tab.moreNavigationController
//
//            if let top = moreNavigationController.topViewController, top.view.window != nil {
//                return topViewController(base: top)
//            } else if let selected = tab.selectedViewController {
//                return topViewController(base: selected)
//            }
//        }
//
//        if let presented = base?.presentedViewController {
//            return topViewController(base: presented)
//        }
//
//        return base
//    }
//
//    func presentTransactionScreen()
//    {
//        let topMostViewController = UIApplication.shared.topMostViewController() as? UINavigationController
//        let storyboard2:UIStoryboard = UIStoryboard(name: "User", bundle: nil)
//        let vc = storyboard2.instantiateViewController(withIdentifier: "TransactionsViewController") as! TransactionsViewController
//        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
////        topMostViewController?.pushViewController(vc, animated: false)
//        topMostViewController?.present(vc, animated: false, completion: nil)
//    }
//
//    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
//        if let navigationController = controller as? UINavigationController {
//            return topViewController(controller: navigationController.visibleViewController)
//        }
//        if let tabController = controller as? UITabBarController {
//            if let selected = tabController.selectedViewController {
//                return topViewController(controller: selected)
//            }
//        }
//        if let presented = controller?.presentedViewController {
//            return topViewController(controller: presented)
//        }
//        return controller
//    }
//
//}
/*
extension UIViewController {
    func presentTransactionScreen()
    {
        let storyboard2:UIStoryboard = UIStoryboard(name: "User", bundle: nil)
        let vc = storyboard2.instantiateViewController(withIdentifier: "TransactionsViewController") as! TransactionsViewController
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.navigationController?.present(vc, animated: false, completion: nil)
        //self.navigationController?.pushViewController(vc, animated: false)
    }
   
    func presentSinupScreen()
        {
            let storyboard2:UIStoryboard = UIStoryboard(name: "User", bundle: nil)
            let vc = storyboard2.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            self.navigationController?.present(vc, animated: false, completion: nil)
           // self.navigationController?.pushViewController(vc, animated: false)
        }
    
    func presentTopStremerLeaderboardScreen()
    {
        let storyboard2:UIStoryboard = UIStoryboard(name: "User", bundle: nil)
        let vc = storyboard2.instantiateViewController(withIdentifier: "TopStremersViewController") as! TopStremersViewController
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
       // self.navigationController?.present(vc, animated: false, completion: nil)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
//    func addBackButton() {
//        let backButton = UIButton(type: .custom)
//        backButton.setImage(UIImage(named: "BackButton.png"), for: .normal) // Image can be downloaded from here below link
//        backButton.setTitle("Back", for: .normal)
//        backButton.setTitleColor(backButton.tintColor, for: .normal) // You can change the TitleColor
//        backButton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
//
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
//    }

    @IBAction func backAction(_ sender: UIButton) {
       let _ = self.dismiss(animated: true, completion: nil)
//        self.navigationController?.popToRootViewController(animated: true)//popViewController(animated:true)

    }
}
*/
