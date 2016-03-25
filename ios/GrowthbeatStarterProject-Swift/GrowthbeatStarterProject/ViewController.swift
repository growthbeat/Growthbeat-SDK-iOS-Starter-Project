//
//  ViewController.swift
//  GrowthbeatStarterProject
//
//  Created by Sota Yamashita on 22/03/2016.
//  Copyright © 2016 Sota Yamashita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initView() {
        self.view.layer.cornerRadius = 7.0
        self.view.layer.opaque = false
    }
    
    @IBAction func randomBtnClicked(sender:AnyObject) {
        GrowthAnalytics.sharedInstance().setRandom();
    }

    @IBOutlet weak var levelTextField: UITextField?
    @IBAction func tapLevelTagButton(sender:AnyObject) {
        GrowthAnalytics.sharedInstance().setLevel((levelTextField!.text! as NSString).intValue)
    }
    
    @IBOutlet weak var developmentTagSwitch: UISwitch?
    @IBAction func switchEnvironment(sender:AnyObject) {
        GrowthAnalytics.sharedInstance().setDevelopment((developmentTagSwitch?.on)!);
    }
    
    @IBOutlet weak var priceTextField: UITextField?
    @IBOutlet weak var itemTextField: UITextField?
    @IBAction func tapPurchaseEventButton(sender:AnyObject) {
        GrowthAnalytics.sharedInstance().purchase(
            (priceTextField!.text! as NSString).intValue,
            setCategory: "item",
            setProduct: itemTextField?.text
        )
    }
}

