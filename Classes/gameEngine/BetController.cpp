/*
 *  BetController.cpp
 *  videopoker
 *
 *  Created by Robert Diel on 12/21/08.
 *  Copyright 2016 Robert Diel. All rights reserved.
 *
 */

#include "BetController.h"
#include "CardGameModel.h"

void BetController::SetMaxBet()
{
	CardGameModel* cgm = CardGameModel::Instance();
	unsigned int accountVal = cgm->GetBank()->getAccountValue();
	if(accountVal <= MAX_BET)
	{
		currentBet = accountVal;
	}
	else
	{
		currentBet = MAX_BET;
	}
}


bool BetController::IncreaseBet()
{
	bool retVal = false;
	CardGameModel* cgm = CardGameModel::Instance();
	unsigned int accountVal = cgm->GetBank()->getAccountValue();
	if(reset == true)
	{
		currentBet = 1;
		reset = false;
	}
	else
	{
		if((currentBet+1 <= MAX_BET) && (currentBet+1 <= accountVal))
		{
			currentBet++;
			retVal = true;
		}
		else 
		{
			currentBet = 1;
		}

	}
	return retVal;
}

bool BetController::DecreaseBet()
{
	bool retVal = false;
	if(currentBet-1 >= 1)
	{
		currentBet--;
		retVal = true;
	}
	return retVal;
}

void BetController::SpendBet()
{
	CardGameModel* cgm = CardGameModel::Instance();
	cgm->GetBank()->spendEscrow();
}
void BetController::EscrowBet()
{
	CardGameModel* cgm = CardGameModel::Instance();
	cgm->GetBank()->escrowCash(currentBet);
}
void BetController::ResetBet()
{
	reset = true;
}