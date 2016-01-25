//
//  CustomUITabBarController.m
//  iPadVideoPoker
//
//  Created by Robert Diel on 4/18/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import "CustomUITabBarController.h"

@implementation CustomUITabBarController

@synthesize tabBar1;
@synthesize settingsViewController;
@synthesize pokerViewController;
@synthesize newGameViewController;

- (void)viewDidLoad {
	[super viewDidLoad];
	

	CGRect frame = CGRectMake(0.0, 0, 1024, 48);
	
	UIView *v = [[UIView alloc] initWithFrame:frame];
	
    //TODO: sample background color, change to that and make the tabs black on white
	[v setBackgroundColor:[[UIColor alloc] initWithRed:0.0
												 green:1.0
												  blue:0.0
												 alpha:0.25]];
	
	[tabBar1 insertSubview:v atIndex:0];
	[v release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{

    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
    {

		[settingsViewController displayHorizontalOrientation:YES];
		[pokerViewController displayHorizontalOrientation:YES];
		[newGameViewController displayHorizontalOrientation:YES];
    }
	else 
	{
		[settingsViewController displayHorizontalOrientation:NO];
		[pokerViewController displayHorizontalOrientation:NO];
		[newGameViewController displayHorizontalOrientation:NO];

	}
	
}
@end
