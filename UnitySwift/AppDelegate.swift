//
//  AppDelegate.swift
//  UnitySwift
//
//  Created by JOY JOSE on 20/03/19.
//  Copyright © 2019 Riverswave Technologies, India. All rights reserved.
//

import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    var application: UIApplication?
    var unityController: UnityAppController?
    
    
    
    func unityWindow() -> UIWindow? {
        return UnityGetMainWindow()
    }
    
    func showUnityWindow() {
        unityWindow()?.makeKeyAndVisible()
    }
    
    func hideUnityWindow() {
        window!.makeKeyAndVisible()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Override point for customization after application launch.
        sleep(3)
        self.application = application
        unity_init(CommandLine.argc, CommandLine.unsafeArgv)
        
        unityController = UnityAppController()
        unityController!.application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
        unityController!.applicationWillResignActive(application)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        unityController!.applicationDidEnterBackground(application)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
        unityController!.applicationWillEnterForeground(application)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        unityController!.applicationDidBecomeActive(application)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
        unityController!.applicationWillTerminate(application)
    }
}
