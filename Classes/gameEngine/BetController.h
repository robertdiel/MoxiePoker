/*
 *  BetController.h
 *  videopoker
 *
 *  Created by Robert Diel on 12/21/08.
 *  Copyright 2016 Robert Diel. All rights reserved.
 *
 */

class BetController
{
private:
	unsigned int currentBet;
	bool reset;
public:
	BetController(){currentBet = 1;reset = false;}
	unsigned int GetCurrentBet(){return currentBet;}
	void SetMaxBet();
	
	//This Function should only be used when setting the bet value when restarting.
	void SetBetValue(int bet) {currentBet = bet; };
	bool IncreaseBet();
	bool DecreaseBet();
	void SpendBet();
	void EscrowBet();
	
	//Reset bet is used to allow the player to change the bet starting at 1 instead of whatever the current 
	//value of the bet.  This is an option in some versions of video poker.
	void ResetBet();
};