//
//  AppDelegate.m
//  GrowthbeatStarterProject
//
//  Created by SIROK, Inc. on 04/03/2016.
//  Copyright © 2016 SIROK, Inc.. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


#pragma mark -
#pragma mark UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // ****************************************************************************
    // Uncomment and fill in with your Growthbeat application id and credentials:
    // NSString *growthbeatAppID = @"your_application_id";
    // NSString *grwothCredentialID = @"your_credential_id";
    // ****************************************************************************
    
    // Initialize Growthbeat
    [[Growthbeat sharedInstance] initializeWithApplicationId:growthbeatAppID credentialId:grwothCredentialID];
    
    // Initialize Growth Push
    [[GrowthPush sharedInstance] requestDeviceTokenWithEnvironment:kGrowthPushEnvironment];
    
    // Initialize Growth Link
    [[GrowthLink sharedInstance] initializeWithApplicationId:growthbeatAppID credentialId:grwothCredentialID];
    
    [[GrowthbeatCore sharedInstance] addIntentHandler:[[GBCustomIntentHandler alloc] initWithBlock:^BOOL(GBCustomIntent *customIntent) {
        NSDictionary *extra = customIntent.extra;
        NSLog(@"extra: %@", extra);
        return YES;
    }]];
    
    return YES;
}


#pragma mark Universal Link

- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [[GrowthLink sharedInstance] handleOpenUrl:url];
    return YES;
}

- (BOOL) application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler
{
    if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        NSURL *webpageURL = userActivity.webpageURL;
        if ( [self handleUniversalLink:webpageURL]){
            [[GrowthLink sharedInstance] handleOpenUrl:webpageURL];
        } else {
            // 例：コンテンツをアプリで開けない時にSafariにリダイレクトする場合
            [[UIApplication sharedApplication] openURL:webpageURL];
            return false;
        }
        
    }
    return true;
}

- (BOOL) handleUniversalLink:(NSURL*) url
{
    NSURLComponents *component = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:true];
    if (!component || !component.host) return false;
    if ([@"gbt.io" isEqualToString:component.host] ) {
        return true;
    }
    return false;
}


#pragma mark Push Notifications

- (void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    // Register device token to Growth Push
    [[GrowthPush sharedInstance] setDeviceToken:deviceToken];
    
    // Filter device token for debug
    NSString* token = [[[[deviceToken description]
                          stringByReplacingOccurrencesOfString: @"<" withString: @""]
                          stringByReplacingOccurrencesOfString: @">" withString: @""]
                          stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSLog(@"Device_Token     -----> %@\n", token);
}

- (void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    if (error.code == 3010) {
        NSLog(@"Push notifications are not supported in the iOS Simulator.");
    } else {
        // Failure to register.
        NSLog(@"didFailToRegisterForRemoteNotificationsWithError: %@", error.description);
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo  {
    NSLog(@"remote notification: %@",[userInfo description]);
    
    if (userInfo) {
        NSLog(@"%@",userInfo);
        
        if ([userInfo objectForKey:@"aps"]) {
            if([[userInfo objectForKey:@"aps"] objectForKey:@"badgecount"]) {
                [UIApplication sharedApplication].applicationIconBadgeNumber = [[[userInfo objectForKey:@"aps"] objectForKey: @"badgecount"] intValue];
            }
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [[Growthbeat sharedInstance] stop];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [[Growthbeat sharedInstance] start];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
