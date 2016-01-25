//
//  GameSelectionView.m
//  iPadVideoPoker
//
//  Created by Robert Diel on 4/2/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import "GameSelectionView.h"
#import "PayTables.h"
#ifdef INCLUDE_ANALYTICS
#import "Flurry.h"
#endif


@implementation GameSelectionView

@synthesize JacksOrBetter96GameButton;
@synthesize JacksOrBetter85GameButton;
@synthesize TensOrBetterGameButton;
@synthesize BonusGameButton;
@synthesize DoubleBonusGameButton;
@synthesize SuperAcesGameButton;

- (id)initWithCoder:(NSCoder*)coder 
{
	if (self = [super initWithCoder:coder])
	{  

        // Initialization code
		[JacksOrBetter96GameButton addTarget:self action:@selector(HandleJacksOrBetter96GameButtonPress:) forControlEvents:UIControlEventTouchUpInside];
		JacksOrBetter85GameButton.alpha = 0;
		
    }
    return self;
}

- (IBAction) HandleJacksOrBetter96GameButtonPress:(id)sender 
{
#ifdef INCLUDE_ANALYTICS
	[FlurryAPI logEvent:@"JB96"];
#endif
	[self dispatchPayTableSelectedNotificationFor:PAYTABLE_JACKS_OR_BETTER_96];
}
- (IBAction) HandleJacksOrBetter85GameButtonPress:(id)sender
{
#ifdef INCLUDE_ANALYTICS
	[FlurryAPI logEvent:@"JB85"];
#endif
	[self dispatchPayTableSelectedNotificationFor:PAYTABLE_JACKS_OR_BETTER_85];
}
- (IBAction) HandleTensOrBetterGameButtonPress:(id)sender
{
#ifdef INCLUDE_ANALYTICS
	[FlurryAPI logEvent:@"T65T"];
#endif
	[self dispatchPayTableSelectedNotificationFor:PAYTABLE_TENS_OR_BETTER_65];
}
- (IBAction) HandleBonusGameButtonPress:(id)sender
{
#ifdef INCLUDE_ANALYTICS
	[FlurryAPI logEvent:@"BTAB"];
#endif
	[self dispatchPayTableSelectedNotificationFor:PAYTABLE_BONUS];
}
- (IBAction) HandleDoubleBonusGameButtonPress:(id)sender
{
#ifdef INCLUDE_ANALYTICS
	[FlurryAPI logEvent:@"DBTAB"];
#endif
	[self dispatchPayTableSelectedNotificationFor:PAYTABLE_DOUBLE_BONUS];
}
- (IBAction) HandleSuperAcesGameButtonPress:(id)sender
{
#ifdef INCLUDE_ANALYTICS
	[FlurryAPI logEvent:@"SATAB"];
#endif
	[self dispatchPayTableSelectedNotificationFor:PAYTABLE_SUPER_ACES];
}
- (void) dispatchPayTableSelectedNotificationFor:(int)payTable
{
	NSNotificationCenter *note = [NSNotificationCenter defaultCenter];
	[note postNotificationName:@"PayTableSelected" object:[NSNumber numberWithInt:payTable]];
}

- (void)dealloc {
    [super dealloc];
}


@end
