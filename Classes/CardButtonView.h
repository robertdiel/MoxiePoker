//
//  CardView.h
//  iPadVideoPoker
//
//  Created by Robert Diel on 3/24/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComposedCardView.h"


@interface CardButtonView : UIView {
	NSNumber* buttonId;
	bool dispatchCompleteEvent;
	bool dispatchEnableDealDrawButtonEvent;
    BOOL animateGlow;
    
    
	IBOutlet ComposedCardView* cardView;
	IBOutlet UIImageView* cardBackView;
	IBOutlet UIImageView* lockImageView;
	IBOutlet UIImageView* glowImageView;
}

@property (nonatomic, retain)  NSNumber* buttonId;
@property (nonatomic, retain) IBOutlet ComposedCardView* cardView;
@property (nonatomic, retain) IBOutlet UIImageView* lockImageView;
@property (nonatomic, retain) IBOutlet UIImageView* glowImageView;
@property (nonatomic, retain) IBOutlet UIImageView* cardBackView;

-(void)flipCardAnimation_Delay:(float)delay;
-(void)sendAnimationCompleteEvent:(bool)val;
-(void)sendEnableDealDrawButton:(bool)val;
-(void)backFlipCardAnimation_Delay:(float)delay;
- (void) hideWinHighlight:(BOOL)hideIt;
- (void) hideHoldIndicator:(BOOL)hideIt;
- (void) grayBackCard:(BOOL) grayIt;
- (void) startGlowAnimation;
@end
