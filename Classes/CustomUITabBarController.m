//
//  CustomUITabBarController.m
//  iPadVideoPoker
//
//  Created by Robert Diel on 4/18/10.
//  Copyright 2010 Moxie Post. All rights reserved.
//

// CustomUITabBarController.m

#import "CustomUITabBarController.h"

@implementation CustomUITabBarController

@synthesize tabBar1;

- (void)viewDidLoad {
	[super viewDidLoad];
	
	CGRect frame = CGRectMake(0.0, 0, self.view.bounds.size.width, 48);
	
	UIView *v = [[UIView alloc] initWithFrame:frame];
	
	[v setBackgroundColor:[[UIColor alloc] initWithRed:0.0
												 green:1.0
												  blue:0.0
												 alpha:0.25]];
	
	[tabBar1 insertSubview:v atIndex:0];
	[v release];
}

@end
