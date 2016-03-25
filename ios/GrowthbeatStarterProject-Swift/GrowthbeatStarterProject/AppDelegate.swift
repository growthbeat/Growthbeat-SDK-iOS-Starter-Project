//
//  AppDelegate.swift
//  GrowthbeatStarterProject
//
//  Created by Sota Yamashita on 22/03/2016.
//  Copyright © 2016 Sota Yamashita. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    #if DEBUG
    let kGPEnvironment:GPEnvironment = GPEnvironment.Development
    #else
    let kGPEnvironment:GPEnvironment = GPEnvironment.Production
    #endif

    //--------------------------------------
    // MARK: - UIApplicationDelegate
    //--------------------------------------

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // ****************************************************************************
        // Uncomment and fill in with your Growthbeat application id and credential id:
        // let growthbeatApplicationID = "Your Growthbeat application ID"
        // let growthbeatCredentialID = "Your Growthbeat credential ID"
        // ****************************************************************************
        
        Growthbeat.sharedInstance().initializeWithApplicationId(growthbeatApplicationID, credentialId: growthbeatCredentialID)
        GrowthLink.sharedInstance().initializeWithApplicationId(growthbeatApplicationID, credentialId: growthbeatCredentialID)
        
        GrowthPush.sharedInstance().requestDeviceTokenWithEnvironment(kGPEnvironment)
        
        GrowthbeatCore.sharedInstance().addIntentHandler(GBCustomIntentHandler(block: {customIntent in
            let extra = customIntent.extra
            print("extra: %@", extra)
            return true
        }))
        
        return true
    }

    //--------------------------------------
    // MARK: Growth Push
    //--------------------------------------
    
    func application( application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData ) {
        GrowthPush.sharedInstance().setDeviceToken(deviceToken)
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        if error.code == 3010 {
            print("Push notifications are not supported in the iOS Simulator.\n")
        } else {
            print("application:didFailToRegisterForRemoteNotificationsWithError: %@\n", error)
        }
    }
    
    //--------------------------------------
    // MARK: Growth Link
    //--------------------------------------
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        GrowthLink.sharedInstance().handleOpenUrl(url)
        return true
    }
    
    func application(application: UIApplication, continueUserActivity userActivity: NSUserActivity, restorationHandler: ([AnyObject]?) -> Void) -> Bool {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
            let webpageURL = userActivity.webpageURL
            if self.handleUniversalLink(webpageURL!) {
                GrowthLink.sharedInstance().handleOpenUrl(webpageURL)
            } else {
                // Example, will be redirected if app connot open content
                UIApplication.sharedApplication().openURL(webpageURL!)
            }
        }
        
        return true
    }
    
    func handleUniversalLink(url: NSURL) -> Bool {
        let component = NSURLComponents(URL: url, resolvingAgainstBaseURL: true)
        if (component == nil || component?.host == nil) {
            return false
        }
        if ("gbt.io" == component!.host) {
            return true
        }
        return false
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

