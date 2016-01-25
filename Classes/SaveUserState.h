//
//  SaveUserState.h
//  iPadVideoPoker
//
//  Created by Robert Diel on 4/11/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SaveUserState : NSObject {
	 NSUserDefaults *defaults;
}
- (void) saveUserIntValue:(int)value forKey:(NSString*)Key;
- (void) saveUserBoolValue:(BOOL)value forKey:(NSString*)Key;
- (int) readUserIntValueForKey:(NSString*)Key;
- (BOOL) readUserBoolValueForKey:(NSString*)Key;
- (void) saveUserStringValue:(NSString*)value forKey:(NSString*)Key;
- (NSString*) readUserStringValueForKey:(NSString*)Key;
- (void) saveUserArrayValue:(NSArray*)value forKey:(NSString*)Key;
- (NSArray*) readUserArrayValueForKey:(NSString*)Key;
+(SaveUserState *) getInstance;

@end
