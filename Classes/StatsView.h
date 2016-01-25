//
//  StatsView.h
//  iPadVideoPoker
//
//  Created by Robert Diel on 4/11/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StatsView : UIView {
	IBOutlet UILabel* GamesWon;
	IBOutlet UILabel* GamesLost;
	IBOutlet UILabel* CreditsWon;
	IBOutlet UILabel* CreditsLost;
	IBOutlet UILabel* MostCreditsWon;
	IBOutlet UILabel* LongestWinStreak;
	IBOutlet UILabel* LongestLoseStreak;
	
	IBOutlet UILabel* GamesWonValue;
	IBOutlet UILabel* GamesLostValue;
	IBOutlet UILabel* CreditsWonValue;
	IBOutlet UILabel* CreditsLostValue;
	IBOutlet UILabel* MostCreditsWonValue;
	IBOutlet UILabel* LongestWinStreakValue;
	IBOutlet UILabel* LongestLoseStreakValue;	
	IBOutlet UILabel* PercentPayoutValue;
	
	IBOutlet UIButton* BackButton;
	
	
}
@property (nonatomic, retain) IBOutlet UIButton* BackButton;
@property (nonatomic, retain) IBOutlet UILabel* GamesWonValue;
@property (nonatomic, retain) IBOutlet UILabel* GamesLostValue;
@property (nonatomic, retain) IBOutlet UILabel* CreditsWonValue;
@property (nonatomic, retain) IBOutlet UILabel* CreditsLostValue;
@property (nonatomic, retain) IBOutlet UILabel* MostCreditsWonValue;
@property (nonatomic, retain) IBOutlet UILabel* LongestWinStreakValue;
@property (nonatomic, retain) IBOutlet UILabel* LongestLoseStreakValue;
@property (nonatomic, retain) IBOutlet UILabel* PercentPayoutValue;


- (void) updateStats;
- (id) init;
@end
