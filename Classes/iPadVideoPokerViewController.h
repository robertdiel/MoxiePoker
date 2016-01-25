//
//  iPadVideoPokerViewController.h
//  iPadVideoPoker
//
//  Created by Robert Diel on 3/22/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PokerController.h"
#import "CardGameModel.h"
#import "BetController.h"
#import <AVFoundation/AVFoundation.h>
#import "SaveUserState.h"
#import "VideoPokerView.h"
//#import "SettingsPopoverViewController.h"
#import "iPadVideoPokerDefs.h"





@interface iPadVideoPokerViewController : UIViewController {
	PokerController* controller;
	BetController   betHandling;
	CardGameModel*   cgm;
	int currentCardsToFlip;
	AVAudioPlayer *audioPlayer;
	SaveUserState* saveState;
		
	UIImageView* horzBkg;
	UIImageView* vertBkg;

}

- (void)synchronizeStats;
- (void) showWin;
- (void) playSoundByName:(NSString*)name andLoop:(Boolean)yesOrNo atVolume:(float)volume;
- (void)displayHorizontalOrientation:(BOOL)yesOrNo;
@property (nonatomic, retain)  IBOutlet UIImageView* horzBkg;
@property (nonatomic, retain)  IBOutlet UIImageView* vertBkg;



@end

