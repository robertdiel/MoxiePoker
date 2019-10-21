    //
//  SettingsPopoverViewController.m
//  iPadVideoPoker
//
//  Created by Robert Diel on 4/14/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import "SettingsPopoverViewController.h"
#import "iPadVideoPokerAppDelegate.h"


@implementation SettingsPopoverViewController
@synthesize SoundEffectsSwitch;
@synthesize MusicSwitch;
@synthesize ClearScores;
@synthesize horzBkg;
@synthesize vertBkg;
@synthesize settingsView;


-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self displayHorizontalOrientation:UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)];
}


- (void)viewDidLoad {
    [super viewDidLoad];
	settingsViewVertOrigin.x = 40;
	settingsViewVertOrigin.y = 65;
	
	settingsViewHorzOrigin.x = 175;
	settingsViewHorzOrigin.y = 20;
	saveState   = [SaveUserState getInstance];
	MusicSwitch.on = [saveState readUserBoolValueForKey:@"musicOn"];
	SoundEffectsSwitch.on = [saveState readUserBoolValueForKey:@"soundFXOn"];
}


- (IBAction) HandleClearScoresButtonPress:(id)sender
{
	UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Clear Scores" message:@"Are you sure?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
	[myAlertView show];
	[myAlertView release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	//Index 0 is cancel
	if(buttonIndex != 0)
	{
		iPadVideoPokerAppDelegate* videoPokerAppDelegate = ((iPadVideoPokerAppDelegate *)[UIApplication sharedApplication].delegate);
		[videoPokerAppDelegate resetStats];
	}
}

- (IBAction) HandleMusicSwitchPress:(id)sender
{
	[saveState saveUserBoolValue:MusicSwitch.on forKey:@"musicOn"];
	iPadVideoPokerAppDelegate* videoPokerAppDelegate = ((iPadVideoPokerAppDelegate *)[UIApplication sharedApplication].delegate);
	[videoPokerAppDelegate turnOnMusic:MusicSwitch.on];

}
- (IBAction) HandleSoundEffectsSwitchPress:(id)sender
{
    //the saved state for the SoundFX button will be use to determine if a sound effect should be played back
	[saveState saveUserBoolValue:SoundEffectsSwitch.on forKey:@"soundFXOn"];
//	iPadVideoPokerAppDelegate* videoPokerAppDelegate = ((iPadVideoPokerAppDelegate *)[UIApplication sharedApplication].delegate);
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self displayHorizontalOrientation:UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewDidUnload {
    [super viewDidUnload];
}
-(void)displayHorizontalOrientation:(BOOL)yesOrNo
{
	if (yesOrNo == YES)
    {
		horzBkg.hidden = NO;
		vertBkg.hidden = YES;
		settingsView.frame = CGRectMake(settingsViewHorzOrigin.x,settingsViewHorzOrigin.y, settingsView.frame.size.width, settingsView.frame.size.height);
    }
	else 
	{
		horzBkg.hidden = YES;
		vertBkg.hidden = NO;
		settingsView.frame = CGRectMake(settingsViewVertOrigin.x,settingsViewVertOrigin.y, settingsView.frame.size.width, settingsView.frame.size.height);
	}
}

- (void)dealloc {
    [super dealloc];
}


@end
