//
//  main.swift
//  UIProgrammatically
//
//  Created by Aditya Narayan on 3/30/17.
//  Copyright © 2017 turntotech. All rights reserved.
//

import Foundation

import UIKit


// mark AppDelegate
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

// mark View
class MyView: UIView{
    
    
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required override init(frame: CGRect) {
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

// mark View Controller
class ViewController: UIViewController {
    
    var myView = MyView(frame: CGRect(x: 20, y: 35, width: 130, height: 50))
    var myImageView = UIImageView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let label = UILabel(frame: CGRect(x: 5, y: 5, width: 100, height: 15 ))
        label.text = "TurnToTech"
        myView.addSubview(label)
        
        self.view.addSubview(myView)
        self.createSegmentControl()
        self.createTextView()
        self.createImageView()
        self.createButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createSegmentControl()  {
        let segmentedControl = UISegmentedControl(frame: CGRect(x: 50, y: 350, width: 150, height: 32))
        segmentedControl.backgroundColor = .white
        segmentedControl.insertSegment(withTitle: "IOS", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "Android", at: 1, animated: true)
        segmentedControl.addTarget(self, action: #selector(handleSegmentChange), for: UIControlEvents.valueChanged)
        self.view.addSubview(segmentedControl)
    }
    
    func handleSegmentChange(sender:UISegmentedControl)  {
        if sender.selectedSegmentIndex == 1 {
            self.myView.backgroundColor = .red
        }else{
            self.myView.backgroundColor = .blue
        }
    }
    
    func handlePan(sender:UIPanGestureRecognizer)
    {
        sender.view?.center = sender.location(in: sender.view?.superview)
    }
    
    func handleButtonTap(sender:Any){
        UIView.animate(withDuration: 0.25, animations: {
                self.myImageView.transform = self.myImageView.transform.rotated(by: CGFloat(M_PI_2))
            })
    }
    
    func createTextView() {
        let myTextView = UITextView(frame: CGRect(x: 0, y: self.view.bounds.size.height - 150, width: self.view.bounds.size.width, height: 150))
        myTextView.backgroundColor = .red
        for _ in 0..<50{
            myTextView.text = myTextView.text.appending("The quick brown fox jumps upon a lazy dog.\n")
            
        }
        myTextView.isEditable = false
        self.view.addSubview(myTextView)
    }
    func createImageView() {
        self.myImageView.image = UIImage(named: "turntotech")
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        self.myImageView.addGestureRecognizer(panGesture)
        self.myImageView.isUserInteractionEnabled = true
        self.view.insertSubview(self.myImageView, at: 0)
    }
    
    func createButton() {
        let button = UIButton(frame: CGRect(x: self.view.bounds.size.width/2, y: 35, width: 60, height: 25))
        
        button.setTitle("Rotate", for: UIControlState.normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(handleButtonTap), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
        
    }
    
}




