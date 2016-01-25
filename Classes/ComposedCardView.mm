//
//  ComposedCardView.m
//  iPadVideoPoker
//
//  Created by Robert Diel on 4/16/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import "ComposedCardView.h"
#import "CardGameModel.h"
#import "CardImageFactory.h"
#import "iPadVideoPokerAppDelegate.h"


@implementation ComposedCardView
@synthesize cardImageView;
@synthesize cardValueLabel;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame]))
    {
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)coder 
{
	if (self = [super initWithCoder:coder])
	{  
    }
    return self;
}


- (void)setup:(int)whichCard
{
	CardGameModel* cgm = CardGameModel::Instance();
	Hand* CurrentHand = cgm->GetCurrentHand();

    PlayingCard& card = CurrentHand->readCard(whichCard);
	string cardName = CardImageFactory::getImageNameByCard(card);
	cardValueLabel.text = [ [NSString stringWithUTF8String:CardImageFactory::getValString(card).c_str()] uppercaseString];
	cardValueLabel.textColor =  ((card.getSuit() == HEART) || (card.getSuit() == DIAMOND))? [UIColor redColor] : [UIColor blackColor];
	NSString* cardNameString = [NSString stringWithUTF8String:cardName.c_str()];

	iPadVideoPokerAppDelegate* videoPokerAppDelegate = ((iPadVideoPokerAppDelegate *)[UIApplication sharedApplication].delegate);
	[cardImageView setImage:[videoPokerAppDelegate getCardImageByName:cardNameString]];
}

- (void)dealloc {
    [super dealloc];
}


@end
