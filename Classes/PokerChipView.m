//
//  PokerChipView.m
//  iPadVideoPoker
//
//  Created by Robert Diel on 4/18/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import "PokerChipView.h"
#import <QuartzCore/QuartzCore.h>

@implementation PokerChipView
@synthesize chipView;
@synthesize largeGlowView;
@synthesize smallGlowView;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code

    }
    return self;
}

- (id)initWithCoder:(NSCoder*)coder 
{
	if (self = [super initWithCoder:coder])
	{  
		self.alpha = 0;
		chipView.alpha = 0;
		largeGlowView.alpha = 0;
		smallGlowView.alpha = 0;		

    }
    return self;
}
double DegreesToRadians(double degrees) {return degrees * M_PI / 180;};
double RadiansToDegrees(double radians) {return radians * 180/M_PI;};

- (void) showChip
{
	self.alpha = 1;
	chipView.alpha = 1;
	largeGlowView.alpha =  0;
	smallGlowView.alpha = 0;
}
- (void) playWinAnimation
{
	self.alpha = 1;

	largeGlowView.alpha =  0;
	smallGlowView.alpha = 0;
	
	CGAffineTransform scaleDown = CGAffineTransformMakeScale(.6, .6);
	largeGlowView.transform = scaleDown;
	smallGlowView.transform = scaleDown;
	
	// large star in
	CABasicAnimation *largeGlowUp = [CABasicAnimation animationWithKeyPath:@"opacity"];
	largeGlowUp.duration = .2;
	largeGlowUp.fromValue = [NSNumber numberWithFloat:0];
	largeGlowUp.toValue = [NSNumber numberWithFloat:.35];
	largeGlowUp.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	largeGlowUp.fillMode = kCAFillModeForwards;
	
	CABasicAnimation* grow = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	grow.fromValue = [NSNumber numberWithFloat:0.35f];
	grow.toValue = [NSNumber numberWithFloat:1.0f];
	grow.duration = .2;
	grow.fillMode = kCAFillModeForwards;
	grow.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

	CABasicAnimation *fullRotationAnimation;
	fullRotationAnimation			= [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
	fullRotationAnimation.fromValue= [NSNumber numberWithFloat:0];
	fullRotationAnimation.toValue	= [NSNumber numberWithFloat:DegreesToRadians(20)];
	fullRotationAnimation.duration	= 1.5;
	fullRotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	fullRotationAnimation.fillMode = kCAFillModeForwards;

	
	// small star in
	CABasicAnimation *smallGlowUp = [CABasicAnimation animationWithKeyPath:@"opacity"];
	smallGlowUp.duration = .3;
	smallGlowUp.fromValue = [NSNumber numberWithFloat:0];
	smallGlowUp.toValue = [NSNumber numberWithFloat:0.8];
	smallGlowUp.fillMode = kCAFillModeForwards;
	smallGlowUp.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	
	CABasicAnimation* smallGrow = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	smallGrow.fromValue = [NSNumber numberWithFloat:0.35f];
	smallGrow.toValue = [NSNumber numberWithFloat:1.0f];
	smallGrow.duration = .3;
	smallGrow.fillMode = kCAFillModeForwards;
	smallGrow.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	
	CABasicAnimation *smallFullRotationAnimation;
	smallFullRotationAnimation			= [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
	smallFullRotationAnimation.fromValue= [NSNumber numberWithFloat:0];
	smallFullRotationAnimation.toValue	= [NSNumber numberWithFloat:DegreesToRadians(90)];
	smallFullRotationAnimation.duration	= 1.3;
	smallFullRotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	smallFullRotationAnimation.fillMode = kCAFillModeForwards;
	
	
	// large star out
	CABasicAnimation* largeShrink = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	largeShrink.fromValue = [NSNumber numberWithFloat:1.0f];
	largeShrink.toValue = [NSNumber numberWithFloat:.3f];
	largeShrink.beginTime = 1.1;
	largeShrink.duration = .5;
	largeShrink.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
	largeShrink.fillMode = kCAFillModeForwards;
	
	CABasicAnimation *largeGlowDown = [CABasicAnimation animationWithKeyPath:@"opacity"];
	largeGlowDown.duration = .4;
	largeGlowDown.beginTime = 1.4;
	largeGlowDown.fromValue = [NSNumber numberWithFloat:.35];
	largeGlowDown.toValue = [NSNumber numberWithFloat:0];	
	largeGlowDown.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];	
	largeGlowDown.fillMode = kCAFillModeForwards;

	
	// small star out
	CABasicAnimation* smallShrink = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	smallShrink.fromValue = [NSNumber numberWithFloat:1.0f];
	smallShrink.toValue = [NSNumber numberWithFloat:.3f];
	smallShrink.beginTime = 1.3;
	smallShrink.duration = 1.1;
	smallShrink.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
	
	CABasicAnimation *smallGlowDown = [CABasicAnimation animationWithKeyPath:@"opacity"];
	smallGlowDown.beginTime = 1.3;
	smallGlowDown.duration = 1;
	smallGlowDown.fromValue = [NSNumber numberWithFloat:0];
	smallGlowDown.toValue = [NSNumber numberWithFloat:0];
	smallGlowDown.fillMode = kCAFillModeForwards;
	smallGlowDown.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
	
		
	CAAnimationGroup *animation = [CAAnimationGroup animation];
	animation.removedOnCompletion = NO;
	animation.autoreverses = NO;
	animation.fillMode = kCAFillModeForwards;
	animation.duration = 5;
	animation.animations = [NSArray arrayWithObjects:largeGlowUp, grow, fullRotationAnimation, largeGlowDown, largeShrink, nil];

	
	CAAnimationGroup *smallAnimation = [CAAnimationGroup animation];
	smallAnimation.removedOnCompletion = NO;
	smallAnimation.autoreverses = NO;
	smallAnimation.fillMode = kCAFillModeForwards;
	smallAnimation.duration = 2;
	smallAnimation.animations = [NSArray arrayWithObjects:smallGlowUp, smallGrow, smallFullRotationAnimation,smallGlowDown, smallShrink,nil];
	
	[largeGlowView.layer addAnimation:animation forKey:@"animateLayer"];
	[smallGlowView.layer addAnimation:smallAnimation forKey:@"smallAnimateLayer"];
	
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
	
}


- (void)dealloc {
    [super dealloc];
}


@end
