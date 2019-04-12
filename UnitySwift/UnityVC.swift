//
//  UnityVC.swift
//  UnitySwift
//
//  Created by JOY JOSE on 21/03/19.
//  Copyright © 2019 Riverswave Technologies, India. All rights reserved.
//

import UIKit

class UnityVC: UIViewController
{
    private var isShowUnityWindow = false
    @IBOutlet private weak var unityViewStart: UIView!
    
    
    @IBOutlet var rotateSwitch: UISwitch!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("unity have entered in View Controller")
        isShowUnityWindow = false
        
    }
    
    
    
    @IBAction func startUnity(_ sender: UIButton)
    {
        isShowUnityWindow = !isShowUnityWindow
        var appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        if isShowUnityWindow {
            appDelegate?.unityWindow()!.frame = CGRect(x: 10, y: 70, width: 350, height: 300)
            appDelegate?.showUnityWindow()
        } else {
            // appDelegate?.hideUnityWindow()
        }
    }
    
    @IBAction func stopUnity(_ sender: UIButton)
    {
        
        isShowUnityWindow = !isShowUnityWindow
        var appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.hideUnityWindow()
        
    }
}
