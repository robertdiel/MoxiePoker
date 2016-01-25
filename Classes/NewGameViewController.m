    //
//  NewGameViewController.m
//  iPadVideoPoker
//
//  Created by Robert Diel on 4/15/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import "NewGameViewController.h"


@implementation NewGameViewController
@synthesize horzBkg;
@synthesize vertBkg;
@synthesize gameSelectionView;


- (void)viewDidLoad {
	saveState   = [SaveUserState getInstance];
	
	gameSelectionViewVertOrigin.x = 40;
	gameSelectionViewVertOrigin.y = 80;
	
	gameSelectionViewHorzOrigin.x = 170;
	gameSelectionViewHorzOrigin.y = 25;
	[saveState saveUserBoolValue:NO forKey:@"payTableSelected"];
    [super viewDidLoad];
}

-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self displayHorizontalOrientation:UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self displayHorizontalOrientation:UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)];
    
}


-(void)displayHorizontalOrientation:(BOOL)yesOrNo
{
	if (yesOrNo == YES)
    {
		gameSelectionView.frame = CGRectMake(gameSelectionViewHorzOrigin.x,gameSelectionViewHorzOrigin.y, 
											 gameSelectionView.frame.size.width, gameSelectionView.frame.size.height);
		horzBkg.hidden = NO;
		vertBkg.hidden = YES;
    }
	else 
	{
		gameSelectionView.frame = CGRectMake(gameSelectionViewVertOrigin.x,gameSelectionViewVertOrigin.y, 
											 gameSelectionView.frame.size.width, gameSelectionView.frame.size.height);

		horzBkg.hidden = YES;
		vertBkg.hidden = NO;
	}
}

@end
