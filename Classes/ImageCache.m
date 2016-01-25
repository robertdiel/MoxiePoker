//
//  ImageCache.m
//  iPadVideoPoker
//
//  Created by Robert Diel on 4/20/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import "ImageCache.h"
#import "CardImageCache.h"

@interface ImageCache(PrivateMethods)

@end

NSMutableDictionary* imageCacheDictionary;
ImageCache* instance;
@implementation ImageCache

+ (ImageCache *)getInstance
{
	@synchronized(self)
	{
		if (!instance)
			instance = [[ImageCache alloc] init];
	}
	return instance;
}

-(id) init
{
	imageCacheDictionary = [[NSMutableDictionary alloc] initWithCapacity:1];
	return self;
}
-(void) fillWithCCharPtrArray:(const char**)array ofLength:(int)length
{	
	
	for(int i = 0; i < length; i++)
	{
		NSString* tempStr = [NSString stringWithUTF8String:array[i]];
		[imageCacheDictionary setObject:[UIImage imageNamed:tempStr] forKey:tempStr];
	}
	NSLog(@"%@",imageCacheDictionary);
}

-(UIImage*) getImageByName:(NSString*)name
{
	return [imageCacheDictionary objectForKey:name];
}
@end
