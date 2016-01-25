/*
 *  CardGameModel.cpp
 *  videopoker
 *
 *  Created by Robert Diel on 11/21/08.
 *  Copyright 2016 Robert Diel. All rights reserved.
 *
 */

#include "CardGameModel.h"

CardGameModel* CardGameModel::pinstance = 0;

CardGameModel* CardGameModel::Instance () 
{
    if (pinstance == 0)
    {
		pinstance = new CardGameModel;
    }
    return pinstance;
}
CardGameModel::CardGameModel() 
{ 
	PlayingCardDeck = new Deck();
	PlayingCardDeck->shuffle();
	CurrentHand = new Hand(5,PlayingCardDeck);
	CurrentHand->DebugPrintOut();
	CurrentWinValue = 0;
	CurrentWinMaxPayOut = 0;
}

Hand* CardGameModel::SetNewHand()
{
	delete CurrentHand;
	CurrentWinValue = 0;
	CurrentWinMaxPayOut = 0;
	CurrentHand = new Hand(5,PlayingCardDeck);
	return CurrentHand;
}

void CardGameModel::Destroy()
{
	delete pinstance;
	pinstance=0;
}

Deck* CardGameModel::GetDeck()
{
	return PlayingCardDeck;
}

Hand* CardGameModel::GetCurrentHand()
{
	return CurrentHand;
}

Bank* CardGameModel::GetBank()
{
	return &CardGameBank;
}

unsigned int CardGameModel::GetWinMaxPayOut()
{
	return CurrentWinMaxPayOut;
}

unsigned int CardGameModel::GetWinValue()
{
	return CurrentWinValue;
}
void CardGameModel::convertHandStatsToWin(vector<HandStat>& hs)
{
	PayOutType tempPOT = currentPayTable.determinePayout(hs);
	if(tempPOT.payout <= 0)
	{
		winType = "Game Over";
		winValue  = -1;
	}
	else
	{
		winType = AllHandTypeStrings[tempPOT.type];
		winValue = tempPOT.type;
		CurrentWinValue = tempPOT.payout;
		CurrentWinMaxPayOut = tempPOT.maxBetPayout;
	}

	cout << winType << endl;
}