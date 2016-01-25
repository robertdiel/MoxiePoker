//
//  SaveUserState.m
//  iPadVideoPoker
//
//  Created by Robert Diel on 4/11/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import "SaveUserState.h"

@interface SaveUserState (Private)
- (void) setUpDefaults;
@end

@implementation SaveUserState

SaveUserState* SUS_Instance;
+ (SaveUserState *)getInstance
{
	@synchronized(self)
	{
		if (!SUS_Instance)
		{
			SUS_Instance = [[SaveUserState alloc] init];
		}
	}
	return SUS_Instance;
}

- (void) setUpDefaults
{
	if (defaults == nil)
	{
		defaults = [NSUserDefaults standardUserDefaults];
	}
}

- (void) saveUserIntValue:(int)value forKey:(NSString*)Key
{			
	[self setUpDefaults];

	[defaults setInteger:value forKey:Key];
	[defaults synchronize];
}
- (int) readUserIntValueForKey:(NSString*)Key
{
	[self setUpDefaults];
	return [defaults integerForKey:Key];
	
}

- (void) saveUserBoolValue:(BOOL)value forKey:(NSString*)Key;
{
	[self setUpDefaults];
	
	[defaults setBool:value forKey:Key];
	[defaults synchronize];
}
- (BOOL) readUserBoolValueForKey:(NSString*)Key
{
	[self setUpDefaults];
	return [defaults integerForKey:Key];
	
}

- (void) saveUserStringValue:(NSString*)value forKey:(NSString*)Key;
{
	[self setUpDefaults];
	[defaults setObject:value forKey:Key];
	[defaults synchronize];
}
- (NSString*) readUserStringValueForKey:(NSString*)Key;
{
	[self setUpDefaults];
	return [defaults stringForKey:Key];
}

- (void) saveUserArrayValue:(NSArray*)value forKey:(NSString*)Key;
{
	[self setUpDefaults];
	[defaults setObject:value forKey:Key];
	[defaults synchronize];
}
- (NSArray*) readUserArrayValueForKey:(NSString*)Key;
{
	[self setUpDefaults];
	return [defaults arrayForKey:Key];
}

- (void)dealloc {
    [super dealloc];
}

@end
