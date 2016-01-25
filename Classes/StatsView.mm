//
//  StatsView.m
//  iPadVideoPoker
//
//  Created by Robert Diel on 4/11/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import "StatsView.h"
#import "CardGameModel.h"


@implementation StatsView

@synthesize BackButton;
@synthesize GamesWonValue;
@synthesize GamesLostValue;
@synthesize CreditsWonValue;
@synthesize CreditsLostValue;
@synthesize MostCreditsWonValue;
@synthesize LongestWinStreakValue;
@synthesize LongestLoseStreakValue;
@synthesize PercentPayoutValue;

- (id)initWithCoder:(NSCoder*)coder 
{
	if (self = [super initWithCoder:coder])
	{  
		[BackButton  addTarget:self action:@selector(HandleBackButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (id) init
{
	[BackButton  addTarget:self action:@selector(HandleBackButtonPress:) forControlEvents:UIControlEventTouchUpInside];
	NSNotificationCenter *note = [NSNotificationCenter defaultCenter];
	[note addObserver:self selector:@selector(HandleUpdateStats:) name:@"updateStats" object:nil];
    
    return self;
}
- (void) HandleUpdateStats:(NSNotification *)note
{
	[self updateStats];
}
- (void) updateStats
{
	CardGameModel* cgm	= CardGameModel::Instance();
	
	GamesWonValue.text = [NSString stringWithFormat:@"%d",cgm->pokerStats.GamesWonStat];
	GamesLostValue.text = [NSString stringWithFormat:@"%d",cgm->pokerStats.GamesLostStat];
	CreditsWonValue.text = [NSString stringWithFormat:@"%d",cgm->pokerStats.CreditsWonStat];
	CreditsLostValue.text = [NSString stringWithFormat:@"%d",cgm->pokerStats.CreditsLostStat];
	MostCreditsWonValue.text = [NSString stringWithFormat:@"%d",cgm->pokerStats.MostCreditsWonStat];
	LongestWinStreakValue.text = [NSString stringWithFormat:@"%d",cgm->pokerStats.LongestWinStreakStat];
	LongestLoseStreakValue.text = [NSString stringWithFormat:@"%d",cgm->pokerStats.LongestLoseStreakStat];

	float payout = 0;
	if(cgm->pokerStats.CreditsWonStat && cgm->pokerStats.CreditsLostStat)
	{
		payout = ((float)cgm->pokerStats.CreditsWonStat)/((float)cgm->pokerStats.CreditsLostStat);
	}
	
	PercentPayoutValue.text = [NSString stringWithFormat:@"%4.2f%%",(payout*100.0)];
}
- (void) HandleBackButtonPress:(id)sender 
{
	NSNotificationCenter *note = [NSNotificationCenter defaultCenter];
	[note postNotificationName:@"StatsBackButtonPressed" object:nil];
	
}

- (void)dealloc {
    [super dealloc];
}


@end
