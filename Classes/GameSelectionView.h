//
//  GameSelectionView.h
//  iPadVideoPoker
//
//  Created by Robert Diel on 4/2/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GameSelectionView : UIView {
	IBOutlet UIButton* JacksOrBetter96GameButton;
	IBOutlet UIButton* JacksOrBetter85GameButton;
	IBOutlet UIButton* TensOrBetterGameButton;
	IBOutlet UIButton* BonusGameButton;
	IBOutlet UIButton* DoubleBonusGameButton;
	IBOutlet UIButton* SuperAcesGameButton;

}
@property (nonatomic, retain)		IBOutlet UIButton* JacksOrBetter96GameButton;
@property (nonatomic, retain)		IBOutlet UIButton* JacksOrBetter85GameButton;
@property (nonatomic, retain)		IBOutlet UIButton* TensOrBetterGameButton;
@property (nonatomic, retain)		IBOutlet UIButton* BonusGameButton;
@property (nonatomic, retain)		IBOutlet UIButton* DoubleBonusGameButton;
@property (nonatomic, retain)		IBOutlet UIButton* SuperAcesGameButton;

-(void) dispatchPayTableSelectedNotificationFor:(int)payTable;

- (IBAction) HandleJacksOrBetter96GameButtonPress:(id)sender;
- (IBAction) HandleJacksOrBetter85GameButtonPress:(id)sender;
- (IBAction) HandleTensOrBetterGameButtonPress:(id)sender;
- (IBAction) HandleBonusGameButtonPress:(id)sender;
- (IBAction) HandleDoubleBonusGameButtonPress:(id)sender;
- (IBAction) HandleSuperAcesGameButtonPress:(id)sender;
@end
