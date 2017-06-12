//
//  iPadVideoPokerViewController.m
//  iPadVideoPoker
//
//  Created by Robert Diel on 3/22/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import "iPadVideoPokerViewController.h"
#import "VideoPokerView.h"
#import "iPadVideoPokerDefs.h"
#import "PokerChipView.h"

#ifdef INCLUDE_ANALYTICS
#import "Flurry.h"
#endif

@interface iPadVideoPokerViewController (Private)
- (void) changeAndDisplayPaytable: (PayTableType)whichTable;
@end

@implementation iPadVideoPokerViewController
@synthesize horzBkg;
@synthesize vertBkg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		
		int currentSelectedPayTable = [saveState readUserIntValueForKey:@"currentSelectedPayTable"];
		cgm->currentPayTable.setCurrentPayTable((PayTableType)currentSelectedPayTable);
		
    }
    return self;
}


-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self displayHorizontalOrientation:UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)];
}

//standard ratio of width to height on poker card is 1.4
- (void)viewDidLoad {
	
	[super viewDidLoad];
	

	controller	= PokerController::Instance();
	cgm			= CardGameModel::Instance();
	saveState   = [SaveUserState getInstance];
	
	[(VideoPokerView*)self.view init];


	//reset Current Bet
	int currentBet = [saveState readUserIntValueForKey:@"currentBet"];
	if(currentBet == 0)
		currentBet = 1;
	betHandling.SetBetValue(currentBet);	
	cgm->currentBet = betHandling.GetCurrentBet();
	[(VideoPokerView*)self.view setBetValue:betHandling.GetCurrentBet()];

	[(VideoPokerView*)self.view setCreditBankValue:cgm->GetBank()->getAccountValue()];

	//reset selected game
	PayTableType currentSelectedPayTable = cgm->currentPayTable.getCurrentPayTableType();
	[self changeAndDisplayPaytable:(PayTableType)currentSelectedPayTable];


	//reset deck for draw state
	NSString* cardDeckTop10 = [saveState readUserStringValueForKey:@"currentDraw"];
	if ([cardDeckTop10 length] != 0)
	{
		cgm->GetDeck()->uncompressStringToCards(10, [cardDeckTop10 UTF8String]);
		betHandling.EscrowBet();
		[(VideoPokerView*)self.view updateBank:cgm->GetBank()->getAccountValue()];

		controller->DrawDealButtonPressed();
		
		[(VideoPokerView*)self.view showDrawState];

	}
	
	NSNotificationCenter *note = [NSNotificationCenter defaultCenter];
	[note addObserver:self selector:@selector(HandleCardButtonPress:) name:@"CardButtonPressed" object:nil];
	[note addObserver:self selector:@selector(HandleDealDrawButtonPressed:) name:@"DealDrawButtonPressed" object:nil];
	[note addObserver:self selector:@selector(HandleMaxButtonPress:) name:@"MaxButtonPressed" object:nil];
	[note addObserver:self selector:@selector(HandleBet1ButtonPress:) name:@"Bet1ButtonPressed" object:nil];
	[note addObserver:self selector:@selector(HandleCardDrawAnimationComplete:) name:@"CardDrawAnimationComplete" object:nil];
	[note addObserver:self selector:@selector(HandleEnableDealDrawButton:) name:@"EnableDealDrawButton" object:nil];
	[note addObserver:self selector:@selector(HandlePayTableSelected:) name:@"PayTableSelected" object:nil];
	[note addObserver:self selector:@selector(HandleStatsBackButtonPressed:) name:@"StatsBackButtonPressed" object:nil];
	[note addObserver:self selector:@selector(HandleMoreGamesButtonPressed:) name:@"MoreGamesButtonPressed" object:nil];
	[note addObserver:self selector:@selector(HandleStatsButtonPressed:) name:@"StatsButtonPressed" object:nil];


}
- (void) HandleMoreGamesButtonPressed:(NSNotification *)note
{
	[saveState saveUserBoolValue:NO forKey:@"payTableSelected"];
	[self playSoundByName:@"menu_press2.aif" andLoop:false  atVolume:0.8];
}
- (void) HandleStatsButtonPressed:(NSNotification *)note
{
	[self playSoundByName:@"menu_press2.aif" andLoop:false  atVolume:0.8];
}
- (void) HandleStatsBackButtonPressed:(NSNotification *)note
{
	[self playSoundByName:@"menu_press2.aif" andLoop:false  atVolume:0.8];

	[(VideoPokerView*)self.view showPayTable];
}
- (void) changeAndDisplayPaytable: (PayTableType)whichTable
{
	cgm->currentPayTable.setCurrentPayTable(whichTable);
	
	[[(VideoPokerView*)self.view payTablePanel] init];
	
	[(VideoPokerView*)self.view showPayTable];
	
}

- (void) HandlePayTableSelected:(NSNotification *)note
{
	[self playSoundByName:@"menu_press1.aif" andLoop:false  atVolume:0.8];
	id obj = [note object];
	
	PayTableType pos = (PayTableType)[obj intValue];
	[self changeAndDisplayPaytable:pos];
	
	[saveState saveUserBoolValue:YES forKey:@"payTableSelected"];
	[saveState saveUserIntValue:pos forKey:@"currentSelectedPayTable"];
	
}
- (void) playSoundByName:(NSString*)name andLoop:(Boolean)yesOrNo atVolume:(float)volume
{
    BOOL playSound = [saveState readUserBoolValueForKey:@"soundFXOn"];
    if(playSound == YES)
    {
        NSError *error;
        NSString* fileURLString = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], name];
        NSURL *url = [NSURL fileURLWithPath:fileURLString];
        [audioPlayer stop];
        [audioPlayer release];
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        audioPlayer.volume = volume;
        if (yesOrNo == true)
        {
            audioPlayer.numberOfLoops = -1;
        }
        else 
        {
            audioPlayer.numberOfLoops = 0;

        }

        [audioPlayer play];
    }
}

- (void) HandleBet1ButtonPress:(id)sender 
{
	[self playSoundByName:@"button_press10.aif" andLoop:false atVolume:0.4];

	betHandling.IncreaseBet();
	cgm->currentBet = betHandling.GetCurrentBet();
	[(VideoPokerView*)self.view setBetValue:betHandling.GetCurrentBet()];
	
	[saveState saveUserIntValue:betHandling.GetCurrentBet() forKey:@"currentBet"];

	
}
- (void) HandleMaxButtonPress:(id)sender 
{
	
	[self playSoundByName:@"button_press10.aif" andLoop:false  atVolume:0.4];

	betHandling.SetMaxBet();
	cgm->currentBet = betHandling.GetCurrentBet();
	[(VideoPokerView*)self.view setBetValue:betHandling.GetCurrentBet()];
	
	[saveState saveUserIntValue:betHandling.GetCurrentBet() forKey:@"currentBet"];

}

- (void) HandleDealDrawButtonPressed:(NSNotification *)note {
	//set draw/deal button state and handle the game play
	string newTitle = controller->DrawDealButtonPressed();
	
    [self playSoundByName:@"button_press10.aif" andLoop:false atVolume:0.4];
    
	[(VideoPokerView*)self.view enableDealDrawButton:NO];

	//in the middle of the game.
	if(newTitle == "Draw")
	{
        [self playSoundByName:@"deal.aif" andLoop:false atVolume:1.0];
        
		betHandling.EscrowBet();
        
		//Display that bet has been spent
		[(VideoPokerView*)self.view updateBank:cgm->GetBank()->getAccountValue()];
		[(VideoPokerView*)self.view showDrawState];
		
		NSString* cardDeckTop10 = [NSString stringWithUTF8String:cgm->GetDeck()->compressCardsToString(10).c_str()];
		[saveState saveUserStringValue:cardDeckTop10 forKey:@"currentDraw"];
		
	}
	else 
	{	

		cgm->GetDeck()->clearOutSavedDeck();
		
		betHandling.SpendBet();

		[(VideoPokerView*)self.view showDealState];
		[saveState saveUserStringValue:@"" forKey:@"currentDraw"];

	}
}
- (void) HandleEnableDealDrawButton:(NSNotification *)note 
{
	[(VideoPokerView*)self.view enableDealDrawButton:YES];

}
- (void) HandleCardDrawAnimationComplete:(NSNotification *)note 
{

	[self showWin];
	
}

- (void) showWin
{
	[(VideoPokerView*)self.view enableDealDrawButton:YES];
	[(VideoPokerView*)self.view enableBetButtons:YES];

	cgm->pokerStats.CreditsLostStat += betHandling.GetCurrentBet();

	if(cgm->winValue >= 0)
	{
		cgm->pokerStats.GamesWonStat++;
#ifdef INCLUDE_ANALYTICS
		[FlurryAPI logEvent:@"WON"];
#endif
		int creditsWon = cgm->GetWinValue()* betHandling.GetCurrentBet();
		if (betHandling.GetCurrentBet() == MAX_BET) 
		{
			creditsWon =  cgm->GetWinMaxPayOut();

		}
		if( creditsWon > cgm->pokerStats.MostCreditsWonStat)
		{
			cgm->pokerStats.MostCreditsWonStat = creditsWon;
		}
		cgm->pokerStats.CurrentWinStreak++;
		if (cgm->pokerStats.CurrentLoseStreak > cgm->pokerStats.LongestLoseStreakStat)
		{
			cgm->pokerStats.LongestLoseStreakStat = cgm->pokerStats.CurrentLoseStreak;
		}
		cgm->pokerStats.CurrentLoseStreak = 0;
		cgm->pokerStats.CreditsWonStat += creditsWon;
		
		[saveState saveUserIntValue:cgm->GetWinValue() forKey:@"winValue"];
		[saveState saveUserStringValue:[NSString stringWithUTF8String:cgm->winType.c_str()] forKey:@"winType"];
		int currentGamesWon = [saveState readUserIntValueForKey:@"GamesWon"]+1;
		[saveState saveUserIntValue:currentGamesWon forKey:@"GamesWon"];

		
		cgm->GetBank()->deposit(creditsWon);

		[(VideoPokerView*)self.view bangWinValue:cgm->GetBank()->getAccountValue()];

		[(VideoPokerView*)self.view updateWinString:[NSString stringWithFormat:@"%s You Win %d Credits",cgm->winType.c_str(),creditsWon]];
		
		bool allCardWinPositions[5] = {false};
        
		//Show wins
		[(VideoPokerView*)self.view playSuccessAnimtion];
		unichar winPositionsCharString[cgm->winPositions.size()];
		for (int i = 0; i < cgm->winPositions.size(); i++) 
		{
			
			int winPositionValue = cgm->winPositions[i]+1;
			allCardWinPositions[winPositionValue-1] = true;
			[(VideoPokerView*)self.view hideWinHightlight:false forCase: cgm->winPositions[i]+1];
			winPositionsCharString[i] = winPositionValue+0x30;
		}
		for(int j = 0; j < 5; j++)
		{
			if(allCardWinPositions[j] == false)
			{
				[(VideoPokerView*)self.view grayCard:true forCase: j+1];
			}
		}
        
		//save win positions
		NSString* winPositions = [NSString stringWithCharacters:winPositionsCharString length:cgm->winPositions.size()];
		[saveState saveUserStringValue:winPositions forKey:@"winPositions"];
		
		
		//win sound
		[self playSoundByName:@"win1.aif" andLoop:false atVolume:1.0];
		
		VideoPokerView* vpv = (VideoPokerView*)self.view;
		[vpv.pokerChipView playWinAnimation];

	}
	else 
	{
#ifdef INCLUDE_ANALYTICS
			[FlurryAPI logEvent:@"LOST"];
#endif

		cgm->pokerStats.GamesLostStat++;
		cgm->pokerStats.CurrentLoseStreak++;
		if (cgm->pokerStats.CurrentWinStreak > cgm->pokerStats.LongestWinStreakStat)
		{
			cgm->pokerStats.LongestWinStreakStat = cgm->pokerStats.CurrentWinStreak;
		}
		cgm->pokerStats.CurrentWinStreak = 0;
		
		//lose sound
		[self playSoundByName:@"lose1.aif" andLoop:false atVolume:1.0];

		
		[(VideoPokerView*)self.view updateWinString:[NSString stringWithFormat:@"%s",cgm->winType.c_str()]];
		
		[saveState saveUserIntValue:cgm->winValue forKey:@"winValue"];
		[saveState saveUserStringValue:[NSString stringWithFormat:@"%s",cgm->winType.c_str()] forKey:@"winType"];
		[saveState saveUserStringValue:@"" forKey:@"winPositions"];
		
		if(betHandling.GetCurrentBet() > cgm->GetBank()->getAccountValue())
		{
			int accountValue = cgm->GetBank()->getAccountValue();
			if (accountValue == 0) 
			{
#ifdef INCLUDE_ANALYTICS
				[FlurryAPI logEvent:@"RLOAD"];
#endif
				cgm->GetBank()->deposit(INITIAL_WALLET);
				[(VideoPokerView*)self.view updateBank:cgm->GetBank()->getAccountValue()];
				
				UIAlertView *charAlert = [[UIAlertView alloc]
										  initWithTitle:@"AUTO RELOAD"
										  message:@"100 more credits loaded."
										  delegate:nil
										  cancelButtonTitle:@"Done"
										  otherButtonTitles:nil];
				
				[charAlert show];
				[charAlert autorelease];
				
			}
			else
			{
				betHandling.SetBetValue(accountValue);
				cgm->currentBet = betHandling.GetCurrentBet();
				[(VideoPokerView*)self.view setBetValue:betHandling.GetCurrentBet()];
				
				[saveState saveUserIntValue:betHandling.GetCurrentBet() forKey:@"currentBet"];
			}
			
		}
		
		for(int j = 0; j < 5; j++)
		{
			[(VideoPokerView*)self.view grayCard:true forCase: j+1];
		}

	}
	[saveState saveUserIntValue:cgm->GetBank()->getAccountValue() forKey:@"bankMoney"];

	cgm->winPositions.clear();
	
	
	NSNotificationCenter *note = [NSNotificationCenter defaultCenter];
	[note postNotificationName:@"updateStats" object:nil];
	
	[note postNotificationName:@"SyncStats" object:nil];

}
- (void)synchronizeStats
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

- (void) HandleCardButtonPress:(NSNotification *)note {
[self playSoundByName:@"holdCard2_vol-10.aif" andLoop:false atVolume:0.3];

	
    id obj = [note object];
	int pos = [obj intValue];
	if(controller->CardHeld(pos-1))
	{
		NSLog(@"UnHoldCard one got %@", obj);
		[(VideoPokerView*)self.view hideHoldIndicator:YES forCase:pos];
		[(VideoPokerView*)self.view moveCardToHoldPosition:NO forCase:pos];
		controller->UnHoldCard(pos-1);
	}
	else
	{
		NSLog(@"HoldCard one got %@", obj);
		[(VideoPokerView*)self.view hideHoldIndicator:NO forCase:pos];
		[(VideoPokerView*)self.view moveCardToHoldPosition:YES forCase:pos];

		
		controller->HoldCard(pos-1);
	}

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self displayHorizontalOrientation:UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)];
}

-(void)displayHorizontalOrientation:(BOOL)yesOrNo
{
	if (yesOrNo == YES)
    {
		horzBkg.hidden = NO;
		vertBkg.hidden = YES;
		[(VideoPokerView*)self.view swapHorizontal:YES];
    }
	else 
	{
		horzBkg.hidden = YES;
		vertBkg.hidden = NO;
		[(VideoPokerView*)self.view swapHorizontal:NO];

	}
}

- (void)dealloc {
	[audioPlayer release];
    [super dealloc];
}

@end
