//
//  CardView.m
//  iPadVideoPoker
//
//  Created by Robert Diel on 3/24/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import "CardButtonView.h"
#import "CardImageFactory.h"
#import "CardGameModel.h"

@implementation CardButtonView

@synthesize buttonId;
//@synthesize cardValueLabel;
//@synthesize cardImageView;
@synthesize cardView;
@synthesize glowImageView;
@synthesize lockImageView;
@synthesize cardBackView;

- (id)initWithCoder:(NSCoder*)coder 
{
	if (self = [super initWithCoder:coder])
	{  
		dispatchCompleteEvent = false;
		animateGlow = NO;
		
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSNotificationCenter *note = [NSNotificationCenter defaultCenter];
	[note postNotificationName:@"CardButtonPressed" object:buttonId];
}

-(void)backFlipCardAnimation_Delay:(float)delay
{
	
	CGAffineTransform scaleDown = CGAffineTransformMakeScale(0.01, 1);
	cardBackView.hidden = NO;
	cardView.hidden = YES;
	cardView.transform = scaleDown;
	
	[self flipCardAnimation_Delay:delay];
}

-(void)flipCardAnimation_Delay:(float)delay
{
	[NSTimer scheduledTimerWithTimeInterval:delay target:self selector:@selector(doFlipCardAnimation) userInfo:nil repeats:NO];
}

-(void)doFlipCardAnimation
{	
	
	CGAffineTransform scaleDown = CGAffineTransformMakeScale(0.01, 1);

	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.2];
	
	cardBackView.transform = scaleDown;
	self.transform  = CGAffineTransformIdentity;
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector: @selector(completeFlipCardAnimation:finished:context:)];
	
	[UIView commitAnimations];
	
	
}
- (void) hideWinHighlight:(BOOL)hideIt
{
	if(hideIt == true)
	{
		glowImageView.alpha = 0;
		glowImageView.hidden = YES;
		animateGlow = NO;
	}
	else if (animateGlow == NO)
	{
		glowImageView.hidden = NO;
		animateGlow = YES;
		[self startGlowAnimation];
	}
}

- (void) grayBackCard:(BOOL) grayIt
{
	if(grayIt == true)
	{
		self.alpha = .5;

	}
	else if (animateGlow == NO)
	{
		self.alpha = 1;
	}
}
- (void) startGlowAnimation
{
	if(animateGlow == YES)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:1];
		
		glowImageView.alpha = 1;
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector: @selector(glowDownAnimation:finished:context:)];
		
		[UIView commitAnimations];

	}
}
-(void)glowDownAnimation:(NSString*) animationID finished:(NSNumber*) finished context:(void*) context 
{
	if(animateGlow == YES)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:1];
		
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

		glowImageView.alpha = 0;
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector: @selector(continueGlowAnimation:finished:context:)];
		
		[UIView commitAnimations];
	}
}
-(void)continueGlowAnimation:(NSString*) animationID finished:(NSNumber*) finished context:(void*) context 
{
	if(animateGlow == YES)
	{
		[self startGlowAnimation];
	}
}

- (void) hideHoldIndicator:(BOOL)hideIt
{
	int hideValue = 1;

	if(hideIt == true)
	{
		hideValue = 0;
	}
	lockImageView.alpha = hideValue;
}
-(void)completeFlipCardAnimation:(NSString*) animationID finished:(NSNumber*) finished context:(void*) context 
{
	cardBackView.hidden = YES;
	cardBackView.transform = CGAffineTransformIdentity;
	cardView.hidden = NO;

	
	[cardView setup:[buttonId intValue]]; 
	CGAffineTransform scaleUp = CGAffineTransformMakeScale(1, 1);
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.2];
	
	cardView.transform = scaleUp;
	
	// Call animateOtherStuff when the animation is done
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector: @selector(animateOtherStuff:finished:context:)];
	
	[UIView commitAnimations];
	
}
-(void)sendEnableDealDrawButton:(bool)val;
{
	dispatchEnableDealDrawButtonEvent = val;
}
-(void)sendAnimationCompleteEvent:(bool)val;
{
	dispatchCompleteEvent = val;
}
- (void)animateOtherStuff:(NSString*) animationID finished:(NSNumber*) finished context:(void*) context 
{
	if(dispatchCompleteEvent == true)
	{
		NSNotificationCenter *note = [NSNotificationCenter defaultCenter];
		[note postNotificationName:@"CardDrawAnimationComplete" object:buttonId];
	}
	dispatchCompleteEvent = false;
	
	if(dispatchEnableDealDrawButtonEvent == true)
	{
		NSNotificationCenter *note = [NSNotificationCenter defaultCenter];
		[note postNotificationName:@"EnableDealDrawButton" object:buttonId];

	}
	dispatchEnableDealDrawButtonEvent = false;
}

- (void)dealloc {
    [super dealloc];
}


@end
