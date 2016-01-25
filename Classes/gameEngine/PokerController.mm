/*
 *  PokerController.cpp
 *  videopoker
 *
 *  Created by Robert Diel on 11/24/08.
 *  Copyright 2016 Robert Diel. All rights reserved.
 *
 */

#include "PokerController.h"

#define POKERPAD_TRACE_POKER_CONTROLLER



PokerController* PokerController::pinstance = 0;

PokerController* PokerController::Instance () 
{
    if (pinstance == 0)
    {
		pinstance = new PokerController;
    }
    return pinstance;
}

PokerController::PokerController() 
{ 
	cgm = CardGameModel::Instance();
	evalEngine = Evaluator::Instance();
	UnHoldAllCards();
	currentGameState = GAME_OVER_STATE;

}

void PokerController::Destroy()
{
	delete pinstance;
	pinstance=0;
}

void PokerController::NewGame()
{
#ifdef POKERPAD_TRACE_POKER_CONTROLLER
	cout << "NEW GAME: " << endl;
#endif
	UnHoldAllCards();
	cgm->GetDeck()->shuffle();
	cgm->SetNewHand();
}
void PokerController::UnHoldAllCards()
{
	for(int i = 0; i < HAND_SIZE; i++)
		UnHoldCard(i);
}
bool PokerController::CardHeld(int position)
{
	return CardsHeld[position];
}
void PokerController::ChangeCardHoldState(int position)
{
	if(CardsHeld[position] == true)
		UnHoldCard(position);
	else 
		HoldCard(position);

}
void  PokerController::HoldCard(int position)
{
#ifdef POKERPAD_TRACE_POKER_CONTROLLER
	cout << "HOLD CARD: " << position << endl;
#endif
	CardsHeld[position] = true;
#ifdef POKERPAD_TRACE_POKER_CONTROLLER
	cout << "CardsHeld: " << position << endl;
#endif

}
void  PokerController::UnHoldCard(int position)
{
#ifdef POKERPAD_TRACE_POKER_CONTROLLER
	cout << "UNHOLD CARD: " << position << endl;
#endif
	CardsHeld[position] = false;
}

string PokerController::DrawDealButtonPressed()
{
	string retVal;
	
	if(currentGameState == GAME_OVER_STATE)
	{
		
		//Deal New Hand
		NewGame();
		retVal = "Draw";
		currentGameState = HOLD_CARD_STATE;
	}
	else
	{
		//set new cards into dealt hand
		setHeldCards();
        
		//Evaluate hand - update win/loss
		evalEngine->buildHandStats(*(cgm->GetCurrentHand()));
		
		
	
		retVal = "Deal";
		currentGameState = GAME_OVER_STATE;
	}
	return retVal;
}

void PokerController::setHeldCards()
{
	
	for(int i = 0; i < HAND_SIZE; i++)
	{
		if(CardsHeld[i] == false)
		{
			cgm->GetCurrentHand()->ReplaceCardWithOneFromDeck(i);
		}
	}
    
#ifdef POKERPAD_TRACE_POKER_CONTROLLER
	cout << "new Hand: ";
	cgm->GetCurrentHand()->DebugPrintOut();
#endif
	
}
