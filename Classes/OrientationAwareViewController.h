//
//  OrientationAwareViewController.h
//  iPadVideoPoker
//
//  Created by Robert Diel on 4/12/10.
//  Copyright 2010 Moxie Post. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HorizontaliPadVideoPokerViewController.h"
#import "iPadVideoPokerViewController.h"

@interface OrientationAwareViewController : UIViewController {
	HorizontaliPadVideoPokerViewController* horizontalController;
	iPadVideoPokerViewController*           verticalController;
}
@property (nonatomic, retain)  HorizontaliPadVideoPokerViewController* horizontalController;
@property (nonatomic, retain)  iPadVideoPokerViewController*           verticalController;

@end
