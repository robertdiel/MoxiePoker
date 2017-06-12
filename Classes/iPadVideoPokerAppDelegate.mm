//
//  iPadVideoPokerAppDelegate.m
//  iPadVideoPoker
//
//  Created by Robert Diel on 3/22/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import "iPadVideoPokerAppDelegate.h"
#import "iPadVideoPokerViewController.h"
#import "iPadVideoPokerDefs.h"
#import "CardImageCache.h"

#ifdef INCLUDE_ANALYTICS
#import "Flurry.h"
#endif

@implementation iPadVideoPokerAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize pokerTabBarController;

void uncaughtExceptionHandler(NSException *exception) {
#ifdef INCLUDE_ANALYTICS
    [FlurryAPI logError:@"Uncaught" message:@"Crash!" exception:exception];
#endif
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
#ifdef INCLUDE_ANALYTICS
	[FlurryAPI startSession:@"9FVQQ6CUY64AD2U7ULNH"];
#endif
	cgm = CardGameModel::Instance();
	saveState   = [SaveUserState getInstance];
	cardImageCache = [ImageCache getInstance];
	[cardImageCache fillWithCCharPtrArray:CardImageCache_pngFileNames ofLength:SIZEOF_CardImageCache_pngFileNames];

#ifdef SAVE_STATE
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	BOOL firstTimeSemiphore = [defaults boolForKey:@"firstTimeSemiphore"];
	
	
	
	int bankMoney = [defaults integerForKey:@"bankMoney"];
	if(bankMoney == 0) 
		bankMoney = INITIAL_WALLET;
	cgm->GetBank()->deposit(bankMoney);
	
	
	int currentSelectedPayTable = [defaults integerForKey:@"currentSelectedPayTable"];
	BOOL payTableSelected = [defaults boolForKey:@"payTableSelected"];
	currentSelectedPayTable = ( (currentSelectedPayTable < (int) PAYTABLE_LAST ) && (currentSelectedPayTable >= 0)) ? currentSelectedPayTable : 0;
	cgm->currentPayTable.setCurrentPayTable((PayTableType)currentSelectedPayTable);

	NSString* cardDeckTop10 = (NSString*)[defaults objectForKey:@"currentDraw"];
	
	if((payTableSelected == YES) || ([cardDeckTop10 length] != 0))
	{
		[pokerTabBarController setSelectedIndex:1];
	}

	cgm->pokerStats.GamesWonStat			= [defaults integerForKey:@"GamesWonStat"];
	cgm->pokerStats.GamesLostStat			= [defaults integerForKey:@"GamesLostStat"];
	cgm->pokerStats.CreditsWonStat			= [defaults integerForKey:@"CreditsWonStat"];
	cgm->pokerStats.CreditsLostStat			= [defaults integerForKey:@"CreditsLostStat"];
	cgm->pokerStats.MostCreditsWonStat		= [defaults integerForKey:@"MostCreditsWonStat"];
	cgm->pokerStats.LongestWinStreakStat	= [defaults integerForKey:@"CurrentWinStreak"];
	cgm->pokerStats.CurrentWinStreak		= [defaults integerForKey:@"LongestWinStreakStat"];
	cgm->pokerStats.LongestLoseStreakStat	= [defaults integerForKey:@"LongestLoseStreakStat"];
	cgm->pokerStats.CurrentLoseStreak		= [defaults integerForKey:@"CurrentLoseStreak"];
	if((cgm->pokerStats.GamesWonStat == 0) && (cgm->pokerStats.GamesLostStat == 0)) 
	{
		cgm->pokerStats.GamesWonStat			= 0;
		cgm->pokerStats.GamesLostStat			= 0;
		cgm->pokerStats.CreditsWonStat			= 0;
		cgm->pokerStats.CreditsLostStat			= 0;
		cgm->pokerStats.MostCreditsWonStat		= 0;
		cgm->pokerStats.CurrentWinStreak        = 0;
		cgm->pokerStats.LongestWinStreakStat	= 0;
		cgm->pokerStats.LongestLoseStreakStat	= 0;
		cgm->pokerStats.CurrentLoseStreak       = 0;

	}
	
	if (firstTimeSemiphore == NO)
	{
		[defaults setBool:YES forKey:@"firstTimeSemiphore"];
		[defaults setBool:YES forKey:@"musicOn"];
		[defaults setBool:YES forKey:@"soundFXOn"];

	}
	
#else
	cgm->GetBank()->deposit(100);
#endif
	
	NSNotificationCenter *note = [NSNotificationCenter defaultCenter];
	[note addObserver:self selector:@selector(HandlePayTableSelected:) name:@"PayTableSelected" object:nil];
	[note addObserver:self selector:@selector(HandleSyncStats:) name:@"SyncStats" object:nil];


    [self.window setRootViewController:pokerTabBarController];
	
    [window makeKeyAndVisible];
	
	[self playMusicTrack];
	
	return YES;
}

-(UIImage*) getCardImageByName:(NSString*)name
{
	return [cardImageCache getImageByName:name];
}
- (void) playMusicTrack
{

    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/ambient_loop_final_01.m4a", [[NSBundle mainBundle] resourcePath]]];
    
    NSError *error;
    
    musicAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    musicAudioPlayer.numberOfLoops = -1;
    musicAudioPlayer.volume = .5;
    [musicAudioPlayer play];

    if ([saveState readUserBoolValueForKey:@"musicOn"] == NO)
    {
        [musicAudioPlayer pause];
    }


}
- (void) turnOnMusic:(BOOL)yesOrNo
{
	if(yesOrNo == YES)
	{
		[musicAudioPlayer play];
	}
	else {
		[musicAudioPlayer pause];
	}
}



- (void) stopMusicTrack
{
	[musicAudioPlayer pause];
}
- (void) HandlePayTableSelected:(NSNotification *)note
{	
	id obj = [note object];
	PayTableType pos = (PayTableType)[obj intValue];
	cgm->currentPayTable.setCurrentPayTable(pos);

	saveState   = [SaveUserState getInstance];

	[saveState saveUserBoolValue:YES forKey:@"payTableSelected"];
	[saveState saveUserIntValue:pos forKey:@"currentSelectedPayTable"];
	
	[pokerTabBarController setSelectedIndex:1];

}





- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController 
{
	if (tabBarController.selectedIndex == 0)
	{
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		NSString* cardDeckTop10 = (NSString*)[defaults objectForKey:@"currentDraw"];
		if([cardDeckTop10 length] != 0)
		{
			UIAlertView *charAlert = [[UIAlertView alloc]
									  initWithTitle:@"ALERT!"
									  message:@"You must complete the hand to change the game"
									  delegate:nil
									  cancelButtonTitle:@"Done"
									  otherButtonTitles:nil];
			
			[charAlert show];
			[charAlert autorelease];
			
			[pokerTabBarController setSelectedIndex:1];
		}
	}
}

- (void)resetStats
{
	cgm->pokerStats.GamesWonStat			= 0;
	cgm->pokerStats.GamesLostStat			= 0;
	cgm->pokerStats.CreditsWonStat			= 0;
	cgm->pokerStats.CreditsLostStat			= 0;
	cgm->pokerStats.MostCreditsWonStat		= 0;
	cgm->pokerStats.CurrentWinStreak        = 0;
	cgm->pokerStats.LongestWinStreakStat	= 0;
	cgm->pokerStats.LongestLoseStreakStat	= 0;
	cgm->pokerStats.CurrentLoseStreak       = 0;
	
	NSNotificationCenter *note = [NSNotificationCenter defaultCenter];
	[note postNotificationName:@"updateStats" object:nil];

	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setInteger:0 forKey:@"GamesWonStat"];
	[defaults setInteger:0 forKey:@"GamesLostStat"];
	[defaults setInteger:0 forKey:@"CreditsWonStat"];
	[defaults setInteger:0 forKey:@"CreditsLostStat"];
	[defaults setInteger:0 forKey:@"MostCreditsWonStat"];
	[defaults setInteger:0 forKey:@"LongestWinStreakStat"];
	[defaults setInteger:0 forKey:@"CurrentWinStreak"];
	[defaults setInteger:0 forKey:@"LongestLoseStreakStat"];
	[defaults setInteger:0 forKey:@"CurrentLoseStreak"];
	[defaults synchronize];
}
- (void)applicationWillTerminate:(UIApplication *)application 
{
	[self syncStats];
}

- (void) HandleSyncStats:(NSNotification *)note
{
	[self syncStats];
}
- (void) syncStats
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setInteger:cgm->pokerStats.GamesWonStat forKey:@"GamesWonStat"];
	[defaults setInteger:cgm->pokerStats.GamesLostStat forKey:@"GamesLostStat"];
	[defaults setInteger:cgm->pokerStats.CreditsWonStat forKey:@"CreditsWonStat"];
	[defaults setInteger:cgm->pokerStats.CreditsLostStat forKey:@"CreditsLostStat"];
	[defaults setInteger:cgm->pokerStats.MostCreditsWonStat forKey:@"MostCreditsWonStat"];
	[defaults setInteger:cgm->pokerStats.LongestWinStreakStat forKey:@"LongestWinStreakStat"];
	[defaults setInteger:cgm->pokerStats.CurrentWinStreak forKey:@"CurrentWinStreak"];
	[defaults setInteger:cgm->pokerStats.LongestLoseStreakStat forKey:@"LongestLoseStreakStat"];
	[defaults setInteger:cgm->pokerStats.CurrentLoseStreak forKey:@"CurrentLoseStreak"];
	[defaults synchronize];
	
}



- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
