//
//  ViewController.m
//  GrowthbeatStarterProject
//
//  Created by SIROK, Inc. on 04/03/2016.
//  Copyright © 2016 SIROK, Inc. All rights reserved.
//

#import "ViewController.h"
#import <Growthbeat/Growthbeat.h>

@interface ViewController ()

@end

@implementation ViewController

@synthesize developmentTagSwitch;
@synthesize levelTextField;
@synthesize itemTextField;
@synthesize priceTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (IBAction)randomBtnClicked:(id)sender
{
     [[GrowthAnalytics sharedInstance] setRandom];
}

- (IBAction)tapLevelTagButton:(id)sender
{
    [[GrowthAnalytics sharedInstance] setLevel:[levelTextField.text intValue]];
}

- (IBAction)switchEnvironment:(id)sender
{
    [[GrowthAnalytics sharedInstance] setDevelopment:developmentTagSwitch.on];
}

- (IBAction) tapPurchaseEventButton:(id)sender {
    [[GrowthAnalytics sharedInstance] purchase:[priceTextField.text intValue] setCategory:@"item" setProduct:itemTextField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void) initView
{
    [self.view.layer setCornerRadius:7.0];
    [self.view.layer setMasksToBounds:YES];
    self.view.layer.opaque = NO;
}

@end
