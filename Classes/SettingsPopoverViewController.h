//
//  SettingsPopoverViewController.h
//  iPadVideoPoker
//
//  Created by Robert Diel on 4/14/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaveUserState.h"
#import "SettingsView.h"


@interface SettingsPopoverViewController : UIViewController {
	UISwitch* SoundEffectsSwitch;
	UISwitch* MusicSwitch;
	UIButton* ClearScores;
	UIImageView* horzBkg;
	UIImageView* vertBkg;
	SettingsView* settingsView;
	SaveUserState* saveState;
	CGPoint settingsViewHorzOrigin;
	CGPoint settingsViewVertOrigin;

	
}
@property (nonatomic, retain)  IBOutlet UISwitch* SoundEffectsSwitch;
@property (nonatomic, retain)  IBOutlet UISwitch* MusicSwitch;
@property (nonatomic, retain)  IBOutlet UIButton* ClearScores;
@property (nonatomic, retain)  IBOutlet UIImageView* horzBkg;
@property (nonatomic, retain)  IBOutlet UIImageView* vertBkg;
@property (nonatomic, retain)  IBOutlet SettingsView* settingsView;
- (IBAction) HandleClearScoresButtonPress:(id)sender;
- (IBAction) HandleMusicSwitchPress:(id)sender;
- (IBAction) HandleSoundEffectsSwitchPress:(id)sender;
-(void)displayHorizontalOrientation:(BOOL)yesOrNo;
@end
