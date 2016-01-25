//
//  iPadVideoPokerAppDelegate.h
//  iPadVideoPoker
//
//  Created by Robert Diel on 3/22/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "CardGameModel.h"
#import "SaveUserState.h"
#import "BetController.h"
#import "ImageCache.h"

@class iPadVideoPokerViewController;

@interface iPadVideoPokerAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    iPadVideoPokerViewController *viewController;
	CardGameModel* cgm;
	IBOutlet UITabBarController* pokerTabBarController;
	SaveUserState* 	saveState;
	AVAudioPlayer *musicAudioPlayer;
	BetController   betHandling;
	ImageCache* cardImageCache;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iPadVideoPokerViewController *viewController;
@property (nonatomic, retain) IBOutlet  UITabBarController* pokerTabBarController;
- (void) resetStats;
- (void) turnOnMusic:(BOOL)yesOrNo;
-(UIImage*) getCardImageByName:(NSString*)name;
- (void) playMusicTrack;
- (void) syncStats;
@end

