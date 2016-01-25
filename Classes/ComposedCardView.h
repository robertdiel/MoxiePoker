//
//  ComposedCardView.h
//  iPadVideoPoker
//
//  Created by Robert Diel on 4/16/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ComposedCardView : UIView {
	IBOutlet UILabel* cardValueLabel;
	IBOutlet UIImageView* cardImageView;
}
- (void)setup:(int)whichCard;

@property (nonatomic, retain) IBOutlet UILabel* cardValueLabel;
@property (nonatomic, retain) IBOutlet UIImageView* cardImageView;
@end
