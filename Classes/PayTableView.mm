//
//  PayTableView.m
//  iPadVideoPoker
//
//  Created by Robert Diel on 4/3/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import "PayTableView.h"
#import "CardGameModel.h"


@implementation PayTableView

@synthesize CurrentPayTableLabel;
@synthesize PayOutHighlight;
- (id)initWithCoder:(NSCoder*)coder 
{
	if (self = [super initWithCoder:coder])
	{  
		
		labelsAllocated = false;
		PayOutHighlightXOrigin = 250;
		
		ValueOfWinStrings = [[NSMutableArray alloc] initWithCapacity:MAX_BET];
		for (int j = 0; j < MAX_BET; j++)
		{
			NSMutableString* tempString = [[NSMutableString alloc] initWithCapacity:100];
			[ValueOfWinStrings addObject:tempString];
		
		}

    }
    return self;
}

- (id) init
{
	CardGameModel& cgm  = *CardGameModel::Instance();
	PayTableType ptt = cgm.currentPayTable.getCurrentPayTableType();

	[self setPayTableLabel:[NSString stringWithUTF8String:PayTableTypeStrings[ptt].c_str()]];
	[self setUpPayTable];
    
    return self;
}

- (void) setPayTableLabel:(NSString*)text
{
	CurrentPayTableLabel.text = text;
}
- (void) labelAllocation
{	
	TypeOfWinLabel = [[NSMutableArray alloc] initWithCapacity:NUMBER_OF_HAND_TYPES];
	ValueOfWinLabel = [[NSMutableArray alloc] initWithCapacity:MAX_BET];

	int largestPaytable = GamePayTable::getLargestPaytableSize();
	
	winLabelView = [[TextColumnView alloc] initWithFrame:self.frame andCapacity:largestPaytable];
	winLabelView.frame = CGRectMake(winLabelView.frame.origin.x, winLabelView.frame.origin.y-10, winLabelView.frame.size.width, winLabelView.frame.size.height);

	[self addSubview:winLabelView];

	for (int j = 1; j <= 5; j++)
	{
		TextColumnView* tempColumnView = [[TextColumnView alloc] initWithFrame:self.frame andCapacity:largestPaytable];
		tempColumnView.frame = CGRectMake(PayOutHighlightXOrigin+80*(j-1), tempColumnView.frame.origin.y-10, tempColumnView.frame.size.width, tempColumnView.frame.size.height);
		[self addSubview: tempColumnView];
		[ValueOfWinLabel addObject:tempColumnView];

	}
	labelsAllocated = true;
}
- (void) updateBet:(int)value
{
	if(value <= MAX_BET)
	{
		int newPayOutHighlightX = PayOutHighlightXOrigin + 15 + (80 * (value-1));
		PayOutHighlight.frame = CGRectMake(newPayOutHighlightX, PayOutHighlight.frame.origin.y, PayOutHighlight.frame.size.width, PayOutHighlight.frame.size.height);

	}

}
- (void) setUpPayTable 
{
	CardGameModel& cgm  = *CardGameModel::Instance();
	int payTableSize = cgm.currentPayTable.getSizeOfCurrentPayTable();
	const PayOutType* paytable = cgm.currentPayTable.getCurrentPayTable();
	
	
	if(labelsAllocated == false)
	{
		[self labelAllocation];
	} 
	
	
	int largestPaytable = GamePayTable::getLargestPaytableSize();
	for(int i = 0; i < largestPaytable; i++)		
	{
		if (i < payTableSize) 
		{

			[winLabelView setText:[NSString stringWithUTF8String:AllHandTypeStrings[paytable[i].type].c_str()] atColumn:i];
			for (int j = 0; j < MAX_BET; j++)
			{

				TextColumnView* tempTextColumnView = (TextColumnView*)[ValueOfWinLabel objectAtIndex:j];
				if ((j+1) == MAX_BET)
				{
					[tempTextColumnView setText:[NSString stringWithFormat:@"%d",paytable[i].maxBetPayout] atColumn:i ];
				}
				else 
				{
					[tempTextColumnView setText:[NSString stringWithFormat:@"%d",paytable[i].payout*(j+1)] atColumn:i];
				}

			}
		}
		else 
		{
			[winLabelView setText:@"" atColumn:i];
			
			for (int j = 0; j < 5; j++)
			{
				TextColumnView* tempTextColumnView = (TextColumnView*)[ValueOfWinLabel objectAtIndex:j];
				[tempTextColumnView setText:@"" atColumn:i];
			}
		}
	}
	for (int j = 0; j < MAX_BET; j++)
	{
		TextColumnView* tempTextColumnView = (TextColumnView*)[ValueOfWinLabel objectAtIndex:j];
		[tempTextColumnView drawTextWithGreenColor:true forWidth:75 andAlignment:UITextAlignmentRight];
	}
	[winLabelView drawTextWithGreenColor:false forWidth:PayOutHighlightXOrigin andAlignment:UITextAlignmentLeft];
}


- (void)dealloc {
    [super dealloc];
}


@end
