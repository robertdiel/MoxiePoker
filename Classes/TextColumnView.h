//
//  TextColumnView.h
//  iPadVideoPoker
//
//  Created by Robert Diel on 5/7/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TextColumnView : UIView {
	NSMutableArray* ValueOfWinStrings;
	int textBoxWidth;
	UITextAlignment textBoxAlignment;
	BOOL shouldBeGreen;
}

- (id)initWithFrame:(CGRect)frame andCapacity:(int)cap;
- (void) setText:(NSString*)str atColumn:(int)which;
- (void) drawTextWithGreenColor:(BOOL)isGreen forWidth:(int)width andAlignment:(UITextAlignment)alignment;
@end
