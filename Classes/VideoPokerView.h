//
//  VideoPokerView.h
//  iPadVideoPoker
//
//  Created by Robert Diel on 3/22/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CardButtonView.h"
#import "PokerController.h"
#import "GameSelectionView.h"
#import "PayTableView.h"
#import "StatsView.h"
#import "PokerChipView.h"
#import "iPadVideoPokerDefs.h"


@interface VideoPokerView : UIView {
	IBOutlet CardButtonView* Card1;
	IBOutlet CardButtonView* Card2;
	IBOutlet CardButtonView* Card3;
	IBOutlet CardButtonView* Card4;
	IBOutlet CardButtonView* Card5;
	
	
	IBOutlet UILabel *WinLabel;
	IBOutlet UILabel *CreditBank;
	IBOutlet UILabel *BetLabel;
	
	
	IBOutlet UIImageView* BetTextLabel;
	IBOutlet UIImageView* CreditsTextLabel;
	IBOutlet UIImageView* CardWellView;
	IBOutlet UIImageView* SuccessImage;

	UIButton* DrawButton;
	UIButton* MaxButton;
	UIButton* Bet1Button;
	
	IBOutlet PokerChipView* pokerChipView;
	
	PokerController* controller;
	
	CardButtonView* cardButtonsQuickReference[5];
	
	GameSelectionView* gameSelectionPanel;
	PayTableView* payTablePanel;
	StatsView* statsPanel;
	
	NSTimer* bangUpAnimation;
	
	UIButton* MoreGamesButton;
	UIButton* statsButton;
	UIButton* payTableButton;

	ViewOriginPoint HorizontalViewOriginPoint[22];
	ViewOriginPoint VerticalViewOriginPoint[22];

	int winValue;
}

#define sizeOf_cardButtonsQuickReference sizeof(cardButtonsQuickReference)/sizeof(CardButtonView*)

@property (nonatomic, retain)	IBOutlet CardButtonView		*Card1;
@property (nonatomic, retain)	IBOutlet CardButtonView		*Card2;
@property (nonatomic, retain)	IBOutlet CardButtonView		*Card3;
@property (nonatomic, retain)	IBOutlet CardButtonView		*Card4;
@property (nonatomic, retain)	IBOutlet CardButtonView		*Card5;

@property (nonatomic, retain) IBOutlet UIImageView* BetTextLabel;
@property (nonatomic, retain) IBOutlet UIImageView* CreditsTextLabel;
@property (nonatomic, retain) IBOutlet UIImageView* CardWellView;

@property (nonatomic, retain) IBOutlet UILabel* WinLabel;
@property (nonatomic, retain) IBOutlet UILabel* CreditBank;
@property (nonatomic, retain) IBOutlet UILabel* BetLabel;

@property (nonatomic, retain) IBOutlet UIButton* DrawButton;
@property (nonatomic, retain) IBOutlet UIButton* MaxButton;
@property (nonatomic, retain) IBOutlet UIButton* Bet1Button;

@property (nonatomic, retain) IBOutlet UIButton* MoreGamesButton;
@property (nonatomic, retain) IBOutlet UIButton* statsButton;
@property (nonatomic, retain) IBOutlet UIButton* payTableButton;

@property (nonatomic, retain) IBOutlet GameSelectionView* gameSelectionPanel;
@property (nonatomic, retain) IBOutlet PayTableView* payTablePanel;
@property (nonatomic, retain) IBOutlet StatsView* statsPanel;


@property (nonatomic, retain) IBOutlet PokerChipView* pokerChipView;


- (void) hideAllHoldIndicators;
- (id) init;
- (void) hideHoldIndicator:(BOOL)hideIt forCase:(int)whichCase;
- (void) showDrawState;
- (void) showDealState;
- (void) setBetValue:(int)val;
- (void) setCreditBankValue:(int)val;
- (void) updateBank:(int)val;
- (void) bangWinValue:(int)val;
- (void) updateWinString:(NSString*)val;
- (void) initGamePlayButtons;
- (void) hideAllWinHightlights;
- (void) hideWinHightlight:(BOOL)hideIt forCase:(int)whichCase;
- (void) enableAllCards:(BOOL)enable;
- (void) moveCardToHoldPosition:(BOOL)moveIt forCase:(int)whichCase;
- (void) setCardPosition:(BOOL)up forView:(CardButtonView *)theView;

- (void) showPayTable;
- (void) showGameSelection;
- (void) showStatsPanel;

- (void) enableDealDrawButton:(BOOL)yesOrNo;
- (void) enableBetButtons:(BOOL)yesOrNo;
- (void)displayHorizontalOrientation:(BOOL)yesOrNo;

- (void) ungrayAllCards;
- (void) grayCard:(BOOL)grayIt forCase:(int)whichCase;

- (void) playSuccessAnimtion;
- (void) hideSuccessAnimation;
- (CAKeyframeAnimation*)bounceAnimationForKeyPath:(NSString*)keyPath initialPosition:(float)kSpringBounceHeight heightAtRest:(float)heightAtRest forDuration:(float)duration;
- (void) populateOrigins;
- (void) swapHorizontal:(BOOL)yesOrNo;
- (void) stopBangUp;
@end
