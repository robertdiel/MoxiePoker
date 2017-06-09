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
	

	CGRect frame = CGRectMake(0.0, 0, 1024, 49);
	
	UIView *v = [[UIView alloc] initWithFrame:frame];
    
    //TODO: sample background color, change to that and make the tabs black on white
	[v setBackgroundColor:[[UIColor alloc] initWithRed:43.0/255.0
                                                 green:77.0/255.0
												  blue:34.0/255.0
												 alpha:1.0]];
    
//    [tabBar1 setTintColor:[UIColor clearColor]];
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
