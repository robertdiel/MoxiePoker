//
//  PokerChipView.h
//  iPadVideoPoker
//
//  Created by Robert Diel on 4/18/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PokerChipView : UIView {
	IBOutlet UIImageView* chipView;
	IBOutlet UIImageView* largeGlowView;
	IBOutlet UIImageView* smallGlowView;	
}
@property (nonatomic, retain)		IBOutlet UIImageView* chipView;
@property (nonatomic, retain)		IBOutlet UIImageView* largeGlowView;
@property (nonatomic, retain)		IBOutlet UIImageView* smallGlowView;
- (void) playWinAnimation;
- (void) showChip;

@end
