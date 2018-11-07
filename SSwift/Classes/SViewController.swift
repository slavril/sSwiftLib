//
//  SViewController.swift
//  FinstroPay
//
//  Created by sondang on 10/3/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

class SViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView?
    @IBOutlet weak var contentView: UIView?
    
    var backgroundTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
    var refreshControl: UIRefreshControl?
    var nTitle: String?
    
    var mainBackgroundColor: UIColor = UIColor.gray
    var contentViewColor: UIColor = UIColor.gray
    var navigationBarColor: UIColor = UIColor.gray
    
    var navigationBarHeight: CGFloat {
        if shouldHideNavigationView() { return 0 }
        
        if let h = navigationController?.navigationBar.frame.size.height {
            return h
        }
        
        return 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add notification observer
        addKeyboardObserver()
        
        // layout setup
        self.view.backgroundColor = mainBackgroundColor
        if let navigationController = self.navigationController {
            navigationController.interactivePopGestureRecognizer?.isEnabled = enabledPopGesture()
            
            if !shouldShowBackArrow() {
                self.navigationItem.setHidesBackButton(true, animated: true)
            }
            
            
            if shouldAddRightButton() {
                navigationItem.rightBarButtonItems = rightButtonItems()
            }
            
            navigationController.navigationBar.barTintColor = navigationBarColor
            navigationController.navigationBar.isTranslucent = shouldTranslucentNavigationBard()
            navigationController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navigationController.navigationBar.shadowImage = UIImage()
        }
        else if shouldAddRightButton() {
            let navItem = UINavigationItem(title: "")
            navItem.rightBarButtonItems = rightButtonItems()
            
            getNavigationBar().setItems([navItem], animated: false)
            getNavigationBar().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            getNavigationBar().shadowImage = UIImage()
        }
        
        // Do any additional setup after loading the view.
        if shouldShowCustomArrow() {
            addCustomArrow()
        }
        
        if contentView != nil {
            contentView!.backgroundColor = contentViewColor
        }
        
        // hide keyboard when user tap outside
        addResignWithBackgroundTap()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if enabledPopGesture() {
            if let navigationController = self.navigationController {
                navigationController.interactivePopGestureRecognizer?.delegate = self
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = shouldHideNavigationView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.removeObserver(self)
        sysPrint("deinit base view controller")
    }
    
    final func shouldShowErrorIfNeed(_ response: ResponseObject) -> Bool {
        if !response.isSuccess {
            showAlert(title: "Error", message: response.errorMessage)
            return true
        }
        
        return false
    }
    
    // MARK: - Resign keyboard
    
    final func addResignWithBackgroundTap() {
        if scrollView != nil {
            scrollView?.addGestureRecognizer(backgroundTapGesture)
        }
        else {
            view.addGestureRecognizer(backgroundTapGesture)
        }
    }
    
    func removeBackgroundTapGesture() {
        if scrollView != nil {
            scrollView?.removeGestureRecognizer(backgroundTapGesture)
        }
        else {
            view.removeGestureRecognizer(backgroundTapGesture)
        }
    }
    
    // handle tap in background
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            view.endEditing(true)
        }
    }
    
    // MARK: - navigation Customize
    
    func enabledPopGesture() -> Bool {
        return false
    }
    
    private func addCustomArrow() {
        let backbutton: UIButton = UIButton(type: .custom)
        backbutton.frame = CGRect(x: 0, y: 0, width: 42, height: 42)
        backbutton.setTitle("", for: .normal)
        backbutton.setImage(UIImage(named: "icon_arrow_black"), for: .normal)
        backbutton.addTarget(self, action: #selector(handleBackButton(sender:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
    }
    
    final func createNavigationButtonItem(button: UIButton) -> UIBarButtonItem {
        let button: UIBarButtonItem = UIBarButtonItem(customView: button)
        return button
    }
    
    final func rightButton() -> UIButton {
        let button: UIButton = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 84, height: 42)
        button.contentHorizontalAlignment = .right
        button.setTitle("button", for: .normal)
        button.setTitleColor(Constant.color.main, for: .normal)
        return button
    }
    
    private var navBar: UINavigationBar?
    
    private func getNavigationBar() -> UINavigationBar {
        if navBar == nil {
            navBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 44))
            navBar!.isTranslucent = true
            let navItem = UINavigationItem(title: "")
            navBar!.setItems([navItem], animated: false)
            self.view.addSubview(navBar!)
        }
        
        return navBar!
    }
    
    func rightButtonItems() -> [UIBarButtonItem]? {
        
        return nil
    }
    
    // turn it true before add your button
    func shouldAddRightButton() -> Bool {
        
        return false
    }
    
    func shouldTranslucentNavigationBard() -> Bool {
        
        return false
    }
    
    final func hasTabbar() -> Bool {
        if tabBarController != nil && tabBarController!.tabBar.isHidden == false {
            return true
        }
        
        return false
    }
    
    // MARK: - pull down refresh
    
    func getPullDownRefresh() -> UIRefreshControl {
        if refreshControl == nil {
            refreshControl = UIRefreshControl()
        }
        
        refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl!.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
        
        return refreshControl!
    }
    
    @objc func refresh(sender:AnyObject) {}
    
    // MARK: - Scroll view control
    final func scrollToRect(_ rect: CGRect) {
        scrollView?.contentInset = UIEdgeInsetsMake(0, 0, Constant.size.keyboardHeight + 10, 0)
        
        if rect.origin.y + rect.size.height + 60 > view.frame.size.height - Constant.size.keyboardHeight {
            scrollView?.setContentOffset(CGPoint(x: 0, y: rect.origin.y + rect.size.height - view.frame.size.height + Constant.size.keyboardHeight + 60), animated: true)
        }
    }
    
    final func exitScroll() {
        view.endEditing(true)
        
        UIView.animate(withDuration: 0.3) {
            self.scrollView?.contentInset = .zero
        }
        
        view.layoutIfNeeded()
    }
    
    // MARK: - Navigation
    final func popToViewController(viewController: AnyClass, navigation: UINavigationController, animated: Bool) {
        for controller in navigation.viewControllers as Array {
            if controller.isKind(of: viewController) {
                navigation.popToViewController(controller, animated: animated)
                break
            }
        }
    }
    
    final func popToViewController(ViewController viewController: AnyClass, navigation: UINavigationController) {
        popToViewController(viewController: viewController, navigation: navigation, animated: true)
    }
    
    class func sviewController() -> SViewController? {
        return storyBoard()?.instantiateViewController(withIdentifier: getClassName()) as? SViewController
    }
    
    class func storyBoard() -> UIStoryboard? {
        return nil
    }
    
    func shouldHideNavigationView() -> Bool {
        return false
    }
    
    func shouldShowBackArrow() -> Bool {
        return true
    }
    
    func shouldShowCustomArrow() -> Bool {
        return true
    }
    
    static func getClassName() -> String {
        return String(describing: self).components(separatedBy: ".").last!
    }
    
    //override this method if needed
    @objc func handleBackButton(sender:UIButton) {
        if self.navigationController != nil {
            self.navigationController!.popViewController(animated: true)
        }
    }
    
    // MARK: - Keyboard handle
    func addKeyboardObserver() {
        NotificationCenter.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide.rawValue, object: nil)
        NotificationCenter.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow.rawValue, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let newHeight: CGFloat
            
            if #available(iOS 11, *) {
                newHeight = keyboardSize.size.height - view.safeAreaInsets.bottom
            }
            else {
                newHeight = keyboardSize.size.height
            }
            
            willShowKeyboard(size: newHeight)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        willHideKeyboard()
    }
    
    func willShowKeyboard(size: CGFloat) {}
    
    func willHideKeyboard() {}
    
    func diableAlertView() -> Bool { return false }

}

// MARK: - UIGestureRecognizerDelegate
extension SViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer is UIScreenEdgePanGestureRecognizer else { return true }
        return navigationController!.viewControllers.count > 1
    }
}

extension SViewController {
    
    func showAlert(title: String, message: String) {
        if diableAlertView() { return }
        
        showAlert(title: title, message: message, okAction: nil)
    }
    
    func showAlert(title: String, message: String, okTitle: String = "OK", okAction: (() -> Void)? ) {
        if diableAlertView() {
            if okAction != nil {
                okAction!()
            }
            
            return
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: okTitle, style: .default, handler: { (actions) in
            if okAction != nil {
                okAction!()
            }
        }))
        
        present(ac, animated: true, completion: nil)
    }
    
}

