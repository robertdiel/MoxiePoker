//
//  PayTableView.h
//  iPadVideoPoker
//
//  Created by Robert Diel on 4/3/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextColumnView.h"


@interface PayTableView : UIView {
	IBOutlet UILabel* CurrentPayTableLabel;
	IBOutlet UIImageView* PayOutHighlight;
	NSMutableArray* TypeOfWinLabel;
	NSMutableArray* ValueOfWinLabel;
	NSMutableArray* ValueOfWinStrings;

	bool labelsAllocated;
	int PayOutHighlightXOrigin;
	
	TextColumnView* winLabelView;
}
@property (nonatomic, retain)		IBOutlet UILabel* CurrentPayTableLabel;
@property (nonatomic, retain)		IBOutlet UIImageView* PayOutHighlight;

- (id) init;
- (void) updateBet:(int)value;
- (void) setPayTableLabel:(NSString*)text;
- (void) setUpPayTable;
@end
