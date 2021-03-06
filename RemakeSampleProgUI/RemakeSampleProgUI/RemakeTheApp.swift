//
//  RemakeTheApp.swift
//  RemakeSampleProgUI
//
//  Created by Aditya Narayan on 4/13/17.
//  Copyright © 2017 George Correa. All rights reserved.
//

import Foundation

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let rootVC = ViewController()
        rootVC.view.backgroundColor = .black
        self.window = UIWindow(frame: UIScreen.main.bounds)
        rootVC.view.frame = (window?.frame)!
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
        
        // Override point for customization after application launch.
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

class YellowView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .yellow
        self.alpha = 0.7
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
    }
}

class ViewController: UIViewController {
    
    var myView = YellowView(frame: CGRect(x: 20, y: 35, width: 130, height: 50))
    var myImage = UIImageView(frame: CGRect(x: 40, y: 150, width: 100, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let myLabel = UILabel(frame: CGRect(x: 5, y: 5, width: 100, height: 15))
        myLabel.text = "TurnToTech"
        myView.addSubview(myLabel)
        
        self.view.addSubview(myView)
        self.createSegmentedController()
        self.createImageView()
        self.createButton()
        self.createTextView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createSegmentedController() {
        let segmentedController = UISegmentedControl(frame: CGRect(x: 50, y: 350, width: 130, height: 30))
        segmentedController.backgroundColor = .white
        segmentedController.insertSegment(withTitle: "iOS", at: 0, animated: true)
        segmentedController.insertSegment(withTitle: "Android", at: 1, animated: true)
        segmentedController.addTarget(self, action: #selector(segmentSelected), for: UIControlEvents.valueChanged)
        self.view.addSubview(segmentedController)
    }
    
    func segmentSelected(sender:UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            myView.backgroundColor = .blue
        }
        else {
            myView.backgroundColor = .red
        }
    }
    
    func panImage(sender:UIPanGestureRecognizer) {
        sender.view?.center = sender.location(in: sender.view?.superview)
    }
    
    func createImageView() {
        myImage.image = UIImage(named: "turntotech")
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panImage))
        myImage.addGestureRecognizer(panGesture)
        myImage.isUserInteractionEnabled = true
        self.view.insertSubview(myImage, at: 0)
    }
    
    func createButton() {
        let myButton = UIButton(frame: CGRect(x: 175, y: 35, width: 70, height: 30))
        myButton.setTitle("Rotate", for: UIControlState.normal)
        myButton.backgroundColor = .blue
        myButton.addTarget(self, action: #selector(buttonTapped), for: UIControlEvents.touchUpInside)
        self.view.addSubview(myButton)
    }
    
    func buttonTapped(sender:Any) {
        UIView.animate(withDuration: 0.25, animations: {
        self.myImage.transform = self.myImage.transform.rotated(by: CGFloat(Double.pi/2))
        })
    }
    
    func createTextView() {
        let myTextView = UITextView(frame: CGRect(x: 0, y: self.view.bounds.size.height - (self.view.bounds.size.height/4), width: self.view.bounds.size.width, height: self.view.bounds.size.height/4))
        myTextView.backgroundColor = .red
        for _ in 0..<50 {
            myTextView.text = myTextView.text.appending("The quick brown fox jumps upon a lazy dog.\n")
        }
        self.view.addSubview(myTextView)
    }
    
    
}
