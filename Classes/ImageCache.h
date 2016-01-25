//
//  ImageCache.h
//  iPadVideoPoker
//
//  Created by Robert Diel on 4/20/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ImageCache : NSObject {

}
+ (ImageCache* ) getInstance;
-(void) fillWithCCharPtrArray:(const char**)array ofLength:(int)length;
-(id) init;
-(UIImage*) getImageByName:(NSString*)name;

@end
