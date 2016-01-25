//
//  CustomUITabBarController.h
//  iPadVideoPoker
//
//  Created by Robert Diel on 4/18/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsPopoverViewController.h"
#import "iPadVideoPokerViewController.h"
#import "NewGameViewController.h"

@interface CustomUITabBarController: UITabBarController {
	IBOutlet UITabBar *tabBar1;
	IBOutlet SettingsPopoverViewController* settingsViewController;
	IBOutlet iPadVideoPokerViewController* pokerViewController;
	IBOutlet NewGameViewController*        newGameViewController;
}

@property(nonatomic, retain) UITabBar *tabBar1;
@property(nonatomic, retain) IBOutlet SettingsPopoverViewController* settingsViewController;
@property(nonatomic, retain) IBOutlet iPadVideoPokerViewController* pokerViewController;
@property(nonatomic, retain) IBOutlet NewGameViewController*        newGameViewController;
@end
//3149715