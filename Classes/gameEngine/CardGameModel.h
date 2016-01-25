/*
 *  CardGameModel.h
 *  videopoker
 *
 *  Created by Robert Diel on 11/21/08.
 *  Copyright 2016 Robert Diel. All rights reserved.
 *
 */
#ifndef __CardGameModel_H
#define __CardGameModel_H
#include "Deck.h"
#include "Hand.h"
#include "Evaluator.h"
#include <string>
#include "PayTables.h"

using namespace std;

#define HAND_SIZE 5

#define FIRST_WINNER PAIR_JACKS_OR_BETTER
const string HandTypeStrings[NUMBER_OF_HAND_TYPES] =
{
	"HIGHCARD",
	"PAIR",
	"JACKS OR BETTER",
	"TWO PAIR",
	"THREE OF A KIND",
	"STRAIGHT",
	"FLUSH",
	"FULL HOUSE",
	"FOUR OF A KIND",
	"STRAIGHT FLUSH",
	"ROYAL FLUSH"
};
const int PayOutLevel[NUMBER_OF_HAND_TYPES] =
{
	0,  //HIGHCARD
	0,  //PAIR
	1,  //PAIR OF JACKS OR BETTER
	2,  //TWO PAIR
	3,  //THREE OF A KIND
	4,  //STRAIGHT
	6,  //FLUSH
	9,  //FULL HOUSE
	25, //FOUR OF A KIND
	50, //STRAIGHT FLUSH
	800 //ROYAL FLUSH
};

struct PokerGameStats {
	int GamesWonStat;
	int GamesLostStat;
	int CreditsWonStat;
	int CreditsLostStat;
	int MostCreditsWonStat;
	int CurrentWinStreak;
	int LongestWinStreakStat;
	int CurrentLoseStreak;
	int LongestLoseStreakStat;
};
#define MAX_BET 5

class CardGameModel
{
public:
	Deck* GetDeck();
	Hand* GetCurrentHand();
	Bank* GetBank();
	
	PokerGameStats pokerStats;
	
	static CardGameModel* Instance();
	Hand* SetNewHand();
	void convertHandStatsToWin(vector<HandStat>& hs);
	
	string winType;
	int winValue;
	vector<int> winPositions;
	
	unsigned int CurrentWinValue;
	unsigned int GetWinValue();
	unsigned int CurrentWinMaxPayOut;
	GamePayTable currentPayTable;
	unsigned int GetWinMaxPayOut();
	unsigned int currentBet;

protected:
	CardGameModel();
	CardGameModel(const CardGameModel&);
	CardGameModel& operator= (const CardGameModel&);
	void Destroy();

private:
	static CardGameModel* pinstance;
	Deck* PlayingCardDeck;
	Hand* CurrentHand;
	Bank CardGameBank;
	
};

#endif
