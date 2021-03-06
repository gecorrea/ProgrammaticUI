//
//  MarvelProgUI.swift
//  ProgrammaticUI
//
//  Created by Aditya Narayan on 4/17/17.
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

//class BackgroundView: UIImageView {
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override required init(frame: CGRect) {
//        super.init(frame: frame)
//
//        self.alpha = 0.7
//        self.layer.cornerRadius = 5
//        self.layer.shadowColor = UIColor.white.cgColor
//        self.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
//        self.layer.shadowRadius = 5
//        self.layer.shadowOpacity = 0.5
//    }
//}

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
//    var myView = BackgroundView(frame: CGRect(x: 0, y: 0, width: , height: 50))
    lazy var backgroundImage : UIImageView = { return UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)) }()
    var hero = UIImageView(frame: CGRect(x: 5, y: 100, width: 100, height: 100))
    var heroIndex:Int = 0
    var villain = UIImageView(frame: CGRect(x: 150, y: 100, width: 100, height: 100))
    var villainIndex:Int = 0
    var backgrounds = ["age_of_ultron", "avengers_tower", "manthing", "secret_wars", "xmansion"]
    var backgroundIndex:Int = 0
    let textField1 = UITextField(frame: CGRect(x: 5, y: 50, width: 50, height: 25))
    let textField2 = UITextField(frame: CGRect(x: 95, y: 50, width: 50, height: 25))
    var sumLabel = UILabel(frame: CGRect(x: 180, y: 50, width: 50, height: 25))
    
    
    var heroes = ["black_widow", "hulk", "iron_man", "ms_marvel", "star_lord", "thor", "wolverine"]
    var villains = ["apocalypse", "carnage", "doctor_doom", "juggernaut", "loki", "magneto", "thanos"]
    
    lazy var myView : UIView = { return UIView(frame: CGRect(x: self.view.bounds.size.width - (self.view.bounds.size.width/4), y: self.view.bounds.size.height - (self.view.bounds.size.height/4), width: self.view.bounds.size.width/4, height: self.view.bounds.size.height/4)) }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.createBackgroud()
        self.createImageView()
        self.createView()
        self.createTextFieldsAndLabels()
        self.createButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createBackgroud() {
        backgroundImage.image = UIImage(named: backgrounds[backgroundIndex])
        backgroundImage.contentMode = .scaleToFill
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation, object: nil)
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(changeBackground))
        backgroundImage.addGestureRecognizer(rightSwipeGesture)
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(changeBackground))
        leftSwipeGesture.direction = .left
        backgroundImage.addGestureRecognizer(leftSwipeGesture)
        backgroundImage.isUserInteractionEnabled = true
        self.view.addSubview(backgroundImage)
    }
    
    
    // allows you to change the background image by swiping the screen
    func changeBackground(sender:UISwipeGestureRecognizer) {
        if(sender.direction == UISwipeGestureRecognizerDirection.left) {
            if(backgroundIndex < backgrounds.count - 1) {
                backgroundIndex += 1
            }
            else {
                backgroundIndex = 0
            }
        }
        else if(sender.direction == UISwipeGestureRecognizerDirection.right) {
            if(backgroundIndex > 0){
                backgroundIndex -= 1
            }
            else {
                backgroundIndex = backgrounds.count - 1
            }
        }
        backgroundImage.image = UIImage(named: backgrounds[backgroundIndex])
    }
    
    // checks if the orientation of the screen has changed and resets characters if it has.
    func rotated() {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            self.backgroundImage.frame = self.view.frame
            backgroundImage.contentMode = .scaleToFill
            hero.gestureRecognizers?.forEach(hero.removeGestureRecognizer)
            villain.gestureRecognizers?.forEach(villain.removeGestureRecognizer)
            self.hero.removeFromSuperview()
            self.villain.removeFromSuperview()
            hero = UIImageView(frame: CGRect(x: 5, y: 100, width: 100, height: 100))
            villain = UIImageView(frame: CGRect(x: 150, y: 100, width: 100, height: 100))
            createImageView()
            myView.frame = CGRect(x: self.view.bounds.size.width - (self.view.frame.size.width/4), y: self.view.frame.size.height - (self.view.frame.size.height/4), width: self.view.frame.size.width/4, height: self.view.frame.size.height/4)
        }
        
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            backgroundImage.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            self.backgroundImage.frame = self.view.frame
            backgroundImage.contentMode = .scaleToFill
            hero.gestureRecognizers?.forEach(hero.removeGestureRecognizer)
            villain.gestureRecognizers?.forEach(villain.removeGestureRecognizer)
            self.hero.removeFromSuperview()
            self.villain.removeFromSuperview()
            hero = UIImageView(frame: CGRect(x: 5, y: 100, width: 100, height: 100))
            villain = UIImageView(frame: CGRect(x: 150, y: 100, width: 100, height: 100))
            createImageView()
            myView.frame = CGRect(x: self.view.bounds.size.width - (self.view.frame.size.width/4), y: self.view.frame.size.height - (self.view.frame.size.height/4), width: self.view.frame.size.width/4, height: self.view.frame.size.height/4)
        }
    }
    
    func createImageView() {
        hero.image = UIImage(named: heroes[heroIndex])
        let heroTapGesture = UITapGestureRecognizer(target: self, action: #selector(changeImage))
        let heroTwoFinger = UITapGestureRecognizer(target: self, action: #selector(changeImage))
        heroTwoFinger.numberOfTouchesRequired = 2
        let heroDoubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        heroDoubleTap.numberOfTapsRequired = 2
        let heroLongPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        let heroPanGesture = UIPanGestureRecognizer(target: self, action: #selector(panImage))
        let heroPinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(imageSize))
        heroPinchGesture.delegate = self
        let heroRotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotateImage))
        heroRotateGesture.delegate = self
        hero.addGestureRecognizer(heroTapGesture)
        hero.addGestureRecognizer(heroTwoFinger)
        hero.addGestureRecognizer(heroDoubleTap)
        hero.addGestureRecognizer(heroLongPress)
        hero.addGestureRecognizer(heroPanGesture)
        hero.addGestureRecognizer(heroPinchGesture)
        hero.addGestureRecognizer(heroRotateGesture)
        hero.isUserInteractionEnabled = true
        hero.isMultipleTouchEnabled = true
        hero.contentMode = .scaleAspectFit
        self.view.addSubview(hero)
        
        
        villain.image = UIImage(named: villains[villainIndex])
        let villainTapGesture = UITapGestureRecognizer(target: self, action: #selector(changeImage))
        let villainTwoFinger = UITapGestureRecognizer(target: self, action: #selector(changeImage))
        villainTwoFinger.numberOfTouchesRequired = 2
        let villainDoubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        villainDoubleTap.numberOfTapsRequired = 2
        let villainLongPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        let villainPanGesture = UIPanGestureRecognizer(target: self, action: #selector(panImage))
        let villainPinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(imageSize))
        villainPinchGesture.delegate = self
        let villainRotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotateImage))
        villainRotateGesture.delegate = self
        villain.addGestureRecognizer(villainTapGesture)
        villain.addGestureRecognizer(villainTwoFinger)
        villain.addGestureRecognizer(villainDoubleTap)
        villain.addGestureRecognizer(villainLongPress)
        villain.addGestureRecognizer(villainPanGesture)
        villain.addGestureRecognizer(villainPinchGesture)
        villain.addGestureRecognizer(villainRotateGesture)
        villain.isUserInteractionEnabled = true
        villain.isMultipleTouchEnabled = true
        villain.contentMode = .scaleAspectFit
        self.view.addSubview(villain)
    }
    
    // allows you to change the character by tapping or two-finger tapping
    func changeImage(sender:UITapGestureRecognizer) {
        if sender.view == hero {
            if (sender.numberOfTouches == 1) {
                if (heroIndex < heroes.count - 1) {
                    heroIndex = heroIndex + 1
                }
                else {
                    heroIndex = 0
                }
            }
            else if (sender.numberOfTouches == 2) {
                if (heroIndex > 0) {
                    heroIndex -= 1
                }
                else {
                    heroIndex = heroes.count - 1
                }
            }
            hero.image = UIImage(named: heroes[heroIndex])
        }
        else if sender.view == villain {
            if (sender.numberOfTouches == 1) {
                if (villainIndex < villains.count - 1) {
                    villainIndex = villainIndex + 1
                }
                else {
                    villainIndex = 0
                }
            }
            else if (sender.numberOfTouches == 2) {
                if(villainIndex > 0){
                    villainIndex = villainIndex - 1
                }
                else {
                    villainIndex = villains.count - 1
                }
            }
            villain.image = UIImage(named: villains[villainIndex])
        }
        
    }
    
    // take you back to first character in character array
    func doubleTap(sender:UITapGestureRecognizer) {
        if sender.view == hero {
            heroIndex = 0
            hero.image = UIImage(named: heroes[heroIndex])
        }
        else if sender.view == villain {
            villainIndex = 0
            villain.image = UIImage(named: villains[villainIndex])
        }
    }
    
    // rotates the character by press holding on them
    func longPress(sender:UILongPressGestureRecognizer) {
        if sender.view == hero {
            UIView.animate(withDuration: 1, animations: {
                self.hero.transform = self.hero.transform.rotated(by: CGFloat(Double.pi/2))
            })
        }
        else if sender.view == villain {
            UIView.animate(withDuration: 1, animations: {
                self.villain.transform = self.villain.transform.rotated(by: CGFloat(Double.pi/2))
            })
        }
    }
    
    // allows you to move characters around on the screen
    func panImage(sender:UIPanGestureRecognizer) {
        sender.view?.center = sender.location(in: sender.view?.superview)
    }
    
    // allows you to resize the characters
    func imageSize(sender:UIPinchGestureRecognizer) {
        sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
        sender.scale = 1.0
    }
    
    // allows the user to rotate the character
    func rotateImage(sender:UIRotationGestureRecognizer) {
        sender.view?.transform = (sender.view?.transform.rotated(by: sender.rotation))!
        sender.rotation = 0
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // create text fields and labels
    func createTextFieldsAndLabels () {
        textField1.placeholder = "x"
        textField1.keyboardType = UIKeyboardType.numberPad
        textField1.font = UIFont.systemFont(ofSize: 15)
        textField1.borderStyle = UITextBorderStyle.roundedRect
        textField1.autocorrectionType = UITextAutocorrectionType.no
        
        textField2.placeholder = "y"
        textField2.keyboardType = UIKeyboardType.numberPad
        textField2.font = UIFont.systemFont(ofSize: 15)
        textField2.borderStyle = UITextBorderStyle.roundedRect
        textField2.autocorrectionType = UITextAutocorrectionType.no
        
        self.view.addSubview(textField1)
        self.view.addSubview(textField2)
        
        let plusLabel = UILabel(frame: CGRect(x: 70, y: 50, width: 15, height: 25))
        plusLabel.text = "+"
        plusLabel.textColor = .red
        self.view.addSubview(plusLabel)
        
        let equalLabel = UILabel(frame: CGRect(x: 160, y: 50, width: 15, height: 25))
        equalLabel.text = "="
        equalLabel.textColor = .red
        self.view.addSubview(equalLabel)
    }
    
    // create button that adds the two values in the text fields
    func createButton() {
        let myButton = UIButton(frame: CGRect(x: 250, y: 50, width: 70, height: 30))
        myButton.setTitle("Sum", for: UIControlState.normal)
        myButton.backgroundColor = .blue
        myButton.addTarget(self, action: #selector(buttonTapped), for: UIControlEvents.touchUpInside)
        self.view.addSubview(myButton)
    }
    
    func buttonTapped(sender:Any) {
        let number1 = Int(textField1.text!)
        let number2 = Int(textField2.text!)
        sumLabel.textColor = .red
        sumLabel.text = String(number1! + number2!)
        self.view.addSubview(sumLabel)
    }
    
    func createView() {
        myView.backgroundColor = .yellow
        self.view.addSubview(myView)
    }
}
