/*
 *  PayTables.h
 *  videopoker
 *
 *  Created by Robert Diel on 7/16/09.
 *  Copyright 2016 Robert Diel. All rights reserved.
 *
 */
#ifndef __Paytables_H
#define __Paytables_H

#include <string>
#include <vector>
#include "Bank.h"
#include "Evaluator.h"

using namespace std;

#define MAX_BET 5
enum HandType
{
	HIGHCARD, //NO MATCHES
	PAIR,
	PAIR_TENS_OR_BETTER,
	PAIR_JACKS_OR_BETTER,
	TWO_PAIR,
	THREE_OF_A_KIND,
	STRAIGHT,
	FLUSH,
	FULL_HOUSE,
	FOUR_OF_A_KIND,
	FOUR_OF_A_KIND_ACES,
	FOUR_OF_A_KIND_234,
	FOUR_OF_A_KIND_5_TO_K,
	STRAIGHT_FLUSH,
	ROYAL_FLUSH,
	NUMBER_OF_HAND_TYPES
};

#ifndef __cplusplus
typedef int AllHandTypes;
#endif
class GamePayTable;

typedef struct 
{
	HandType type;
	int payout;
	int maxBetPayout;
	bool (GamePayTable::*evaluatorEquation)(vector<HandStat>&);
} PayOutType;
	
const string AllHandTypeStrings[NUMBER_OF_HAND_TYPES] =
{
	"High card",
	"Pair",
	"Tens or better",
	"Jacks or better",
	"Two pair",
	"Three of a kind",
	"Straight",
	"Flush",
	"Full house",
	"Four of a kind",
	"Four of a kind ACES",
	"Four of a kind 2,3,4",
	"Four of a kind 5-K",
	"Straight flush",
	"Royal flush"
};
enum PayTableType
{
	PAYTABLE_JACKS_OR_BETTER_96,
	PAYTABLE_JACKS_OR_BETTER_85,
	PAYTABLE_TENS_OR_BETTER_65,
	PAYTABLE_BONUS,
	PAYTABLE_DOUBLE_BONUS,
	PAYTABLE_SUPER_ACES,
	PAYTABLE_LAST
};
const string PayTableTypeStrings[PAYTABLE_LAST] =
{
	"9/6 Jacks or Better",
	"8/5 Jacks or Better",
	"Tens or Better",
	"Bonus",
	"Double Bonus",
	"Super Aces"
};

#ifndef __cplusplus
typedef int PayTableType;
#endif

class GamePayTable
{
private:
	const PayOutType* currentPayTable;
	PayTableType currentPayTableType;
	//CardGameModel* cgm;
	int sizeOfPayTable;
public:
	const PayOutType* getCurrentPayTable() { return currentPayTable; };
	PayTableType getCurrentPayTableType() { return currentPayTableType; };
	const int getSizeOfCurrentPayTable() {return sizeOfPayTable; };
	static const int getLargestPaytableSize();
	void setCurrentPayTable(PayTableType pt);
	GamePayTable();
	
	const PayOutType* getPayTableByType(PayTableType pt);
	
	PayOutType determinePayout(vector<HandStat>& hs);
	
	bool  CheckForFourOfAKind(vector<HandStat>& hs);
	int   CheckForFourOfAKindValue(vector<HandStat>& hs);
	bool   CheckForFourOfAKindAces(vector<HandStat>& hs);
	bool   CheckForFourOfAKind234(vector<HandStat>& hs);
	bool   CheckForFourOfAKind5ToK(vector<HandStat>& hs);
	bool   CheckForFourOfAKindAceDeuce(vector<HandStat>& hs);
	
	bool  CheckForFullHouse(vector<HandStat>& hs);
	bool  CheckForThreeOfAKind(vector<HandStat>& hs);
	bool  CheckForTwoPair(vector<HandStat>& hs);
	bool  CheckForStraightFlush(vector<HandStat>& hs);
	bool  CheckForRoyalFlush(vector<HandStat>& hs);
	bool  CheckForFlush(vector<HandStat>& hs);
	
	bool  CheckForStraight(vector<HandStat>& hs);
	
	bool  CheckForJacksOrBetterPair(vector<HandStat>& hs);
	bool  CheckForTensOrBetterPair(vector<HandStat>& hs);
	bool  CheckForPair(vector<HandStat>& hs, int* cv);
	
};
#endif