//
//  TextColumnView.m
//  iPadVideoPoker
//
//  Created by Robert Diel on 5/7/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import "TextColumnView.h"


@implementation TextColumnView


- (id)initWithFrame:(CGRect)frame andCapacity:(int)cap
{
    if ((self = [super initWithFrame:frame])) 
	{
		self.backgroundColor = [UIColor clearColor];
        // Initialization code
		ValueOfWinStrings = [[NSMutableArray alloc] initWithCapacity:cap];
		for (int j = 0; j < cap; j++)
		{
			NSMutableString* tempString = [[NSMutableString alloc] initWithCapacity:100];
			[ValueOfWinStrings addObject:tempString];
		}
		shouldBeGreen = true;

    }
    return self;
}

- (void) setText:(NSString*)str atColumn:(int)which
{
	NSMutableString* tempString = [ValueOfWinStrings objectAtIndex:which];
	[tempString setString:str];
	//NSLog(tempString);
}

- (void) drawTextWithGreenColor:(BOOL)isGreen forWidth:(int)width andAlignment:(UITextAlignment)alignment
{

	textBoxWidth = width;
	textBoxAlignment = alignment;
	shouldBeGreen = isGreen;
	
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {

	if(shouldBeGreen == true)
	{
		UIColor* greenColor =  [UIColor colorWithRed:150.0/255.0 green:204.0/255.0 blue:4.0/255.0 alpha:1.0];
		[greenColor set];
	}
	else 
	{
		[[UIColor whiteColor] set];
	}

    // Drawing code
	UIFont *displayFont = [UIFont fontWithName:@"Helvetica" size:20];
	NSLog(@"drawing");

	for (int i = 0; i < [ValueOfWinStrings count]; i++)
	{
		NSMutableString* tempString = [ValueOfWinStrings objectAtIndex:i];
		[tempString drawInRect:CGRectMake(0, i*30, textBoxWidth, 20) withFont:displayFont lineBreakMode:UILineBreakModeClip alignment:textBoxAlignment];
	}
}


- (void)dealloc {
    [super dealloc];
}


@end
