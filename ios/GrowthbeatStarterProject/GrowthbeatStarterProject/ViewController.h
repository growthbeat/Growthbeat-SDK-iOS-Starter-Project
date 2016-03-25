//
//  ViewController.h
//  GrowthbeatStarterProject
//
//  Created by SIROK, Inc. on 04/03/2016.
//  Copyright © 2016 SIROK, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    IBOutlet UISwitch *developmentTagSwitch;
}

@property (nonatomic, strong) IBOutlet UISwitch *developmentTagSwitch;
@property (nonatomic, strong) IBOutlet UITextField *levelTextField;
@property (nonatomic, strong) IBOutlet UITextField * itemTextField;
@property (nonatomic, strong) IBOutlet UITextField * priceTextField;

@end

