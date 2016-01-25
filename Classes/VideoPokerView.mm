//
//  VideoPokerView.m
//  iPadVideoPoker
//
//  Created by Robert Diel on 3/22/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import "VideoPokerView.h"


@implementation VideoPokerView
@synthesize Card1;
@synthesize Card2;
@synthesize Card3;
@synthesize Card4;
@synthesize Card5;

@synthesize BetTextLabel;
@synthesize CreditsTextLabel;
@synthesize CardWellView;

@synthesize BetLabel;
@synthesize WinLabel;
@synthesize CreditBank; //4,347

@synthesize DrawButton;
@synthesize Bet1Button;
@synthesize MaxButton;
@synthesize statsButton;

@synthesize gameSelectionPanel;
@synthesize payTablePanel; //168,23
@synthesize statsPanel;    //168,23

@synthesize MoreGamesButton;
@synthesize payTableButton;

@synthesize pokerChipView;  //37,39


- (id)initWithCoder:(NSCoder*)coder 
{
	if (self = [super initWithCoder:coder])
	{  
		controller = PokerController::Instance();
    }
    return self;
}

- (void) init
{
	[self populateOrigins];

	Card1.buttonId = [NSNumber numberWithInt:1];
	Card2.buttonId = [NSNumber numberWithInt:2];
	Card3.buttonId = [NSNumber numberWithInt:3];
	Card4.buttonId = [NSNumber numberWithInt:4];
	Card5.buttonId = [NSNumber numberWithInt:5];
	
	cardButtonsQuickReference[0] = Card1;
	cardButtonsQuickReference[1] = Card2;
	cardButtonsQuickReference[2] = Card3;
	cardButtonsQuickReference[3] = Card4;
	cardButtonsQuickReference[4] = Card5;
	
	[self hideAllHoldIndicators];
	[self hideAllWinHightlights];
	[self initGamePlayButtons];
	[self setBetValue:10];
	[self enableAllCards:false];
	
	DrawButton.enabled = false;
	MoreGamesButton.enabled = false;
	[gameSelectionPanel init];
	[statsPanel init];
	[payTablePanel init];
	[pokerChipView showChip];
	SuccessImage.alpha = 0;
	
}
- (void) populateOrigin:(CGPoint*)point withX:(int)x andY:(int)y
{
	point->x = x;
	point->y = y;
}
- (void) populateOrigins
{
	HorizontalViewOriginPoint[0].populate( Card1,195,490);
	HorizontalViewOriginPoint[1].populate( Card2,323,490);
	HorizontalViewOriginPoint[2].populate( Card3,452,490);
	HorizontalViewOriginPoint[3].populate( Card4,580,490);
	HorizontalViewOriginPoint[4].populate( Card5,708,490);
	HorizontalViewOriginPoint[5].populate( WinLabel,158,438);
	HorizontalViewOriginPoint[6].populate( CreditBank,7,336);
	HorizontalViewOriginPoint[7].populate( BetLabel,902,480);
	
	HorizontalViewOriginPoint[8].populate( DrawButton,878,579);	
	HorizontalViewOriginPoint[9].populate( Bet1Button,-10,501);
	HorizontalViewOriginPoint[10].populate( MaxButton,-10,579);
	
	HorizontalViewOriginPoint[11].populate( pokerChipView,-75,228);
	HorizontalViewOriginPoint[12].populate( gameSelectionPanel,0,-15);
	HorizontalViewOriginPoint[13].populate( payTablePanel,168,8);
	HorizontalViewOriginPoint[14].populate( statsPanel,168,8);
	HorizontalViewOriginPoint[15].populate( MoreGamesButton,0,0);
	HorizontalViewOriginPoint[16].populate( statsButton,511,406);
	HorizontalViewOriginPoint[17].populate( payTableButton,170,396);
	
	HorizontalViewOriginPoint[18].populate( BetTextLabel,935,453);
	HorizontalViewOriginPoint[19].populate( CreditsTextLabel,13,453);
	HorizontalViewOriginPoint[20].populate( CardWellView,133,463);
	HorizontalViewOriginPoint[21].populate( SuccessImage,380,568);
	
	VerticalViewOriginPoint[0].populate( Card1,50,557);
	VerticalViewOriginPoint[1].populate( Card2,180,557);
	VerticalViewOriginPoint[2].populate( Card3,310,557);
	VerticalViewOriginPoint[3].populate( Card4,440,557);
	VerticalViewOriginPoint[4].populate( Card5,570,557);
	
	VerticalViewOriginPoint[5].populate( WinLabel,40,502);
	VerticalViewOriginPoint[6].populate( CreditBank,102,905);
	VerticalViewOriginPoint[7].populate( BetLabel,418,789);
	VerticalViewOriginPoint[8].populate( DrawButton,544,772);
	VerticalViewOriginPoint[9].populate( MaxButton,230,772);
	VerticalViewOriginPoint[10].populate( Bet1Button,60,772);
	VerticalViewOriginPoint[11].populate( pokerChipView,20,804);
	VerticalViewOriginPoint[12].populate( gameSelectionPanel,0,0);
	VerticalViewOriginPoint[13].populate( payTablePanel,40,63);
	VerticalViewOriginPoint[14].populate( statsPanel,40,63);
	VerticalViewOriginPoint[15].populate( MoreGamesButton,0,0);
	VerticalViewOriginPoint[16].populate( statsButton,383,461);
	VerticalViewOriginPoint[17].populate( payTableButton,42,451);
	VerticalViewOriginPoint[18].populate( BetTextLabel,449,773);
	VerticalViewOriginPoint[19].populate( CreditsTextLabel,249,912);
	VerticalViewOriginPoint[20].populate( CardWellView,0,533);
	VerticalViewOriginPoint[21].populate( SuccessImage,232,637);

	
}

-(void) swapHorizontal:(BOOL)yesOrNo
{
	if(yesOrNo == YES)
	{
		for(int i = 0; i < 22; i++)
		{
			CGRect frameRect = CGRectMake(HorizontalViewOriginPoint[i].origin.x, HorizontalViewOriginPoint[i].origin.y, 
										  HorizontalViewOriginPoint[i].view.frame.size.width, 
										  HorizontalViewOriginPoint[i].view.frame.size.height);
			HorizontalViewOriginPoint[i].view.frame = frameRect;
		}
		UIFont *displayFont = [UIFont fontWithName:@"Helvetica" size:60];
		BetLabel.font = displayFont;
	}
	else 
	{
		for(int j = 0; j < 22; j++)
		{
			CGRect frameRect = CGRectMake(VerticalViewOriginPoint[j].origin.x, VerticalViewOriginPoint[j].origin.y, 
										  VerticalViewOriginPoint[j].view.frame.size.width, 
										  VerticalViewOriginPoint[j].view.frame.size.height);
			VerticalViewOriginPoint[j].view.frame = frameRect;
		}
		UIFont *displayFont = [UIFont fontWithName:@"Helvetica" size:40];
		BetLabel.font = displayFont;
	}
	//retain position of held cards.
	for(int i = 0; i < sizeOf_cardButtonsQuickReference; i++)
	{
		if(controller->CardHeld(i) == false)
		{

			cardButtonsQuickReference[i].frame = CGRectMake(cardButtonsQuickReference[i].frame.origin.x,
															cardButtonsQuickReference[i].frame.origin.y-10, 
															cardButtonsQuickReference[i].frame.size.width, 
															cardButtonsQuickReference[i].frame.size.height);
		}
	}
}

- (void) showPayTable
{
	payTablePanel.alpha = 1;
	gameSelectionPanel.alpha = 0;
	statsPanel.alpha = 0;
	
	DrawButton.enabled = true;
	statsButton.selected = NO;
	statsPanel.BackButton.selected = YES; 
	if(DrawButton.titleLabel.text == @"Deal")
	{
		MoreGamesButton.enabled = true;
	}
}
- (void) showGameSelection
{
	DrawButton.enabled = false;
	MoreGamesButton.enabled = false;
	
	payTablePanel.alpha = 0;
	gameSelectionPanel.alpha = 1;
	statsPanel.alpha = 0;

}

- (void) showStatsPanel
{	
	
	if(DrawButton.titleLabel.text == @"Deal")
	{
		MoreGamesButton.enabled = true;
	}
	statsButton.selected = YES;
	statsPanel.BackButton.selected = NO; 
	
	payTablePanel.alpha = 0;
	statsPanel.alpha = 1;
	gameSelectionPanel.alpha = 0;
}

- (void)moveCardToHoldPosition:(BOOL)moveIt forCase:(int)whichCase
{
	[self setCardPosition:moveIt forView:cardButtonsQuickReference[whichCase-1]];
}
- (void)setCardPosition:(BOOL)up forView:(CardButtonView *)theView 
{
	// Pulse the view by scaling up, then move the view to under the finger.
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:.1];
	CGAffineTransform transform;
	if(up == true)
		transform = CGAffineTransformMakeTranslation(0, 10);
	else
		transform = CGAffineTransformMakeTranslation(0, 0);
	theView.transform = transform;
	[UIView commitAnimations];
}
- (void) hideAllHoldIndicators
{
	for(int i = 0; i < sizeOf_cardButtonsQuickReference; i++)
	{
		[cardButtonsQuickReference[i] hideHoldIndicator:YES];
	}
	
}
- (void) hideHoldIndicator:(BOOL)hideIt forCase:(int)whichCase
{
	[cardButtonsQuickReference[whichCase-1] hideHoldIndicator:hideIt];

}
- (void) hideAllWinHightlights
{
	for(int i = 0; i < sizeOf_cardButtonsQuickReference; i++)
	{
		[cardButtonsQuickReference[i] hideWinHighlight:true];
	}
	
}
- (void) hideWinHightlight:(BOOL)hideIt forCase:(int)whichCase
{
	[cardButtonsQuickReference[whichCase-1] hideWinHighlight:hideIt];
}

- (void) grayCard:(BOOL)grayIt forCase:(int)whichCase
{
	[cardButtonsQuickReference[whichCase-1] grayBackCard:grayIt];
}
- (void) ungrayAllCards
{
	for(int i = 0; i < sizeOf_cardButtonsQuickReference; i++)
	{
		[cardButtonsQuickReference[i] grayBackCard:false];
	}
	
}
- (void) enableAllCards:(BOOL)enable
{
	for(int i = 0; i < sizeOf_cardButtonsQuickReference; i++)
	{
		cardButtonsQuickReference[i].userInteractionEnabled = enable;
	}
	
}
- (void) HandleBet1ButtonPress:(id)sender 
{
	NSNotificationCenter *note = [NSNotificationCenter defaultCenter];
	[note postNotificationName:@"Bet1ButtonPressed" object:nil];
	//[pokerChipView playWinAnimation];
	
}
- (void) HandleMaxButtonPress:(id)sender 
{
	NSNotificationCenter *note = [NSNotificationCenter defaultCenter];
	[note postNotificationName:@"MaxButtonPressed" object:nil];
}

- (void) HandleMoreGamesButtonPress:(id)sender 
{
	MoreGamesButton.enabled = false;
	NSNotificationCenter *note = [NSNotificationCenter defaultCenter];
	[note postNotificationName:@"MoreGamesButtonPressed" object:nil];
	[self showGameSelection];
}
- (void) HandleStatsButtonPress:(id)sender 
{
	NSNotificationCenter *note = [NSNotificationCenter defaultCenter];
	[note postNotificationName:@"StatsButtonPressed" object:nil];

	[statsPanel updateStats];
	[self showStatsPanel];
	
}
- (void) initGamePlayButtons
{
	[DrawButton setTitle:@"Deal"  forState:UIControlStateNormal];
	[DrawButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
	[Bet1Button addTarget:self action:@selector(HandleBet1ButtonPress:) forControlEvents:UIControlEventTouchUpInside];
	[MaxButton  addTarget:self action:@selector(HandleMaxButtonPress:) forControlEvents:UIControlEventTouchUpInside];
	[MoreGamesButton  addTarget:self action:@selector(HandleMoreGamesButtonPress:) forControlEvents:UIControlEventTouchUpInside];
	[statsButton  addTarget:self action:@selector(HandleStatsButtonPress:) forControlEvents:UIControlEventTouchUpInside];
	
}

- (void) setBetValue:(int)val;
{
	
	BetLabel.text = [NSString stringWithFormat:@"%d",val ];	
	[payTablePanel updateBet:val];
}

- (void) setCreditBankValue:(int)val;
{
	CreditBank.text = [NSString stringWithFormat:@"%d", val];;	
}

- (void) initGamePlayTextFields
{
	WinLabel.text = @"Game Over";
}

- (void) buttonClick:(id)sender 
{
	NSLog(@"DEAL DRAW BUTTON CLICKED");
	[self hideAllWinHightlights];
	[self hideSuccessAnimation];
	[self ungrayAllCards];
	[self stopBangUp];
	NSNotificationCenter *note = [NSNotificationCenter defaultCenter];
	[note postNotificationName:@"DealDrawButtonPressed" object:nil];
}
- (void) updateBank:(int)val
{
	CreditBank.text = [NSString stringWithFormat:@"%d", val];	
}
- (void) updateWinString:(NSString*)val
{
	WinLabel.text = val;
}
- (void) bangWinValue:(int)val
{
	
	winValue = val;
	
	//we now assume that the bank value has the win value already in it, for safety sake.
	bangUpAnimation = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(doBangUp) userInfo:nil repeats:YES];
}
- (void) playSuccessAnimtion
{
	SuccessImage.hidden = NO;

	CABasicAnimation *alphaIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
	alphaIn.duration = .2;
	alphaIn.fromValue = [NSNumber numberWithFloat:0];
	alphaIn.toValue = [NSNumber numberWithFloat:1];
	alphaIn.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	alphaIn.fillMode = kCAFillModeForwards;


	CAAnimationGroup *successAnimation = [CAAnimationGroup animation];
	successAnimation.removedOnCompletion = NO;
	successAnimation.autoreverses = NO;
	successAnimation.fillMode = kCAFillModeForwards;
	successAnimation.duration = 1;
	successAnimation.animations = [NSArray arrayWithObjects:alphaIn,nil];
	
	[SuccessImage.layer addAnimation:successAnimation forKey:@"animateLayer"];
	
}


- (void) hideSuccessAnimation
{
	SuccessImage.alpha = 0;
	SuccessImage.hidden = YES;

}
- (void) doBangUp
{
	int currentBank = [CreditBank.text intValue];
	if(currentBank != winValue)
	{
		currentBank++;
	}
	else
	{
		winValue = 0;
		[bangUpAnimation invalidate];
	}
	CreditBank.text = [NSString stringWithFormat:@"%d", currentBank];	
}

- (void) stopBangUp
{
	
	if(winValue != 0)
	{
		[bangUpAnimation invalidate];
		CreditBank.text = [NSString stringWithFormat:@"%d", winValue];
		winValue = 0;
	}

}
- (void) enableDealDrawButton:(BOOL)yesOrNo
{
	DrawButton.enabled = yesOrNo;
}
- (void) enableBetButtons:(BOOL)yesOrNo
{
	Bet1Button.enabled = yesOrNo;
	MaxButton.enabled  = yesOrNo;
}
- (void) showDrawState
{
	[self enableAllCards:true];
	[self enableBetButtons:false];
	MoreGamesButton.enabled = false;

	
	WinLabel.text = @"Pick Cards To Hold";
	[self hideAllHoldIndicators];

	[DrawButton setTitle:@"Draw"  forState:UIControlStateNormal];

	int i =0;
	for(i = 0; i < sizeOf_cardButtonsQuickReference; i++)
	{
		[cardButtonsQuickReference[i] backFlipCardAnimation_Delay:0.1*(i+1)];
	}
	[cardButtonsQuickReference[i-1] sendEnableDealDrawButton:YES];

}
- (void) showDealState
{
	[self enableAllCards:false];

	MoreGamesButton.enabled = true;

	
	[DrawButton setTitle:@"Deal"  forState:UIControlStateNormal];

	
	//Set up card animation
	int notHeldCardCounter = 1;
	int dispatcher = -1;
	for(int i = 0; i < sizeOf_cardButtonsQuickReference; i++)
	{
		if(controller->CardHeld(i) == false)
		{
			dispatcher = i;
			[cardButtonsQuickReference[i] backFlipCardAnimation_Delay:0.1*notHeldCardCounter++];
		}
	}
    
	//If any of the cards are not held dispatch the animation complete event on the last card not held.
	//If all cards are held then immediately dispatch the animation complete event.
	if (dispatcher != -1)
	{
		[cardButtonsQuickReference[dispatcher] sendAnimationCompleteEvent:true];
	}
	else
	{
		NSNotificationCenter *note = [NSNotificationCenter defaultCenter];
		[note postNotificationName:@"CardDrawAnimationComplete" object:nil];
	}

}

// keyPath for the spring is @"bounds.size.height"
// keyPath for Jack's head is @"position.y"
- (CAKeyframeAnimation*)bounceAnimationForKeyPath:(NSString*)keyPath
						  initialPosition:(float)kSpringBounceHeight
							 heightAtRest:(float)heightAtRest
							  forDuration:(float)duration
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    // Create arrays for values and associated timings.
    NSMutableArray *values = [NSMutableArray array];
    NSMutableArray *timings = [NSMutableArray array];
    float bounceHeight = kSpringBounceHeight;
    while (bounceHeight > kSpringBounceHeight) {
        
        // Bounce up
        float bounceTop = heightAtRest + bounceHeight;
        [values addObject:[NSNumber numberWithFloat:bounceTop]];
        [timings addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        
        // Return to rest
        [values addObject:[NSNumber numberWithFloat:heightAtRest]];
        [timings addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        
        // Reduce the height of the bounce by the spring's tension
        bounceHeight *= .4;
    }
    animation.values = values;
    animation.timingFunctions = timings;
    return animation;
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{

}

-(void)displayHorizontalOrientation:(BOOL)yesOrNo
{
}

- (void)dealloc {
    [super dealloc];
}


@end
