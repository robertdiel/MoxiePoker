/*
 *  PokerController.h
 *  videopoker
 *
 *  Created by Robert Diel on 11/24/08.
 *  Copyright 2016 Robert Diel. All rights reserved.
 *
 */
#ifndef __POKERCONTROLLER_H
#define __POKERCONTROLLER_H

#include "CardGameModel.h"
#include "Evaluator.h"
#include <vector>

using namespace std;


class PokerController
{
	
public:
	enum PokerGameState
	{
		GAME_OVER_STATE,
		HOLD_CARD_STATE
	};
	
	static PokerController* Instance();
	void Destroy();
	void ChangeCardHoldState(int position);
	void NewGame();
	bool CardHeld(int position);
	void HoldCard(int position);
	void UnHoldCard(int position);
	string DrawDealButtonPressed();
	PokerGameState getCurrentGameState(){return currentGameState;}
	
protected:
	PokerController();
	PokerController(const PokerController&);
	PokerController& operator= (const PokerController&);

	
private:
	PokerGameState currentGameState;
	void UnHoldAllCards();
	CardGameModel* cgm;
	Evaluator* evalEngine;
	bool CardsHeld[HAND_SIZE];
	static PokerController* pinstance;
	void setHeldCards();
	
	
};

#endif