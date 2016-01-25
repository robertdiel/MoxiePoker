/*
 *  PayTables.cpp
 *  videopoker
 *
 *  Created by Robert Diel on 7/16/09.
 *  Copyright 2016 Robert Diel. All rights reserved.
 *
 */

#include "PayTables.h"
#include "CardGameModel.h"

#define POKERPAD_TRACE_PAY_TABLES


static const PayOutType TensOrBetter65_PAIR_TENS_OR_BETTER = { PAIR_TENS_OR_BETTER, 1, 1*MAX_BET, &GamePayTable::CheckForTensOrBetterPair};
static const PayOutType TensOrBetter65_TWO_PAIR = { TWO_PAIR, 2, 2*MAX_BET, &GamePayTable::CheckForTwoPair};
static const PayOutType TensOrBetter65_THREE_OF_A_KIND = { THREE_OF_A_KIND, 3, 3*MAX_BET, &GamePayTable::CheckForThreeOfAKind};
static const PayOutType TensOrBetter65_STRAIGHT = { STRAIGHT, 4,4*MAX_BET, &GamePayTable::CheckForStraight};
static const PayOutType TensOrBetter65_FLUSH = { FLUSH, 6,6*MAX_BET, &GamePayTable::CheckForFlush};
static const PayOutType TensOrBetter65_FULL_HOUSE = { FULL_HOUSE, 9,9*MAX_BET, &GamePayTable::CheckForFullHouse};
static const PayOutType TensOrBetter65_FOUR_OF_A_KIND = { FOUR_OF_A_KIND, 25,25*MAX_BET, &GamePayTable::CheckForFourOfAKind};
static const PayOutType TensOrBetter65_STRAIGHT_FLUSH = { STRAIGHT_FLUSH, 50,50*MAX_BET, &GamePayTable::CheckForStraightFlush};
static const PayOutType TensOrBetter65_ROYAL_FLUSH = { ROYAL_FLUSH, 250,4000, &GamePayTable::CheckForRoyalFlush};

static const PayOutType TensOrBetter65_PayTable[] = 
{ 
	TensOrBetter65_ROYAL_FLUSH, 
	TensOrBetter65_STRAIGHT_FLUSH,
	TensOrBetter65_FOUR_OF_A_KIND,
	TensOrBetter65_FULL_HOUSE,
	TensOrBetter65_FLUSH,
	TensOrBetter65_STRAIGHT,
	TensOrBetter65_THREE_OF_A_KIND,
	TensOrBetter65_TWO_PAIR,
	TensOrBetter65_PAIR_TENS_OR_BETTER 
};


static const PayOutType JacksOrBetter96_PAIR_JACKS_OR_BETTER = { PAIR_JACKS_OR_BETTER, 1, 1*MAX_BET, &GamePayTable::CheckForJacksOrBetterPair};
static const PayOutType JacksOrBetter96_TWO_PAIR = { TWO_PAIR, 2, 2*MAX_BET, &GamePayTable::CheckForTwoPair};
static const PayOutType JacksOrBetter96_THREE_OF_A_KIND = { THREE_OF_A_KIND, 3, 3*MAX_BET, &GamePayTable::CheckForThreeOfAKind};
static const PayOutType JacksOrBetter96_STRAIGHT = { STRAIGHT, 4, 4*MAX_BET, &GamePayTable::CheckForStraight};
static const PayOutType JacksOrBetter96_FLUSH = { FLUSH, 6, 6*MAX_BET, &GamePayTable::CheckForFlush};
static const PayOutType JacksOrBetter96_FULL_HOUSE = { FULL_HOUSE, 9, 9*MAX_BET, &GamePayTable::CheckForFullHouse};
static const PayOutType JacksOrBetter96_FOUR_OF_A_KIND = { FOUR_OF_A_KIND, 25, 25*MAX_BET, &GamePayTable::CheckForFourOfAKind};
static const PayOutType JacksOrBetter96_STRAIGHT_FLUSH = { STRAIGHT_FLUSH, 50, 50*MAX_BET, &GamePayTable::CheckForStraightFlush};
static const PayOutType JacksOrBetter96_ROYAL_FLUSH = { ROYAL_FLUSH, 250,4000, &GamePayTable::CheckForRoyalFlush};


static const PayOutType JacksOrBetter96_PayTable[] = 
{ 
	JacksOrBetter96_ROYAL_FLUSH, 
	JacksOrBetter96_STRAIGHT_FLUSH,
	JacksOrBetter96_FOUR_OF_A_KIND,
	JacksOrBetter96_FULL_HOUSE,
	JacksOrBetter96_FLUSH,
	JacksOrBetter96_STRAIGHT,
	JacksOrBetter96_THREE_OF_A_KIND,
	JacksOrBetter96_TWO_PAIR,
	JacksOrBetter96_PAIR_JACKS_OR_BETTER 
};

static const PayOutType JacksOrBetter85_PAIR_JACKS_OR_BETTER = { PAIR_JACKS_OR_BETTER, 1, 1*MAX_BET, &GamePayTable::CheckForJacksOrBetterPair};
static const PayOutType JacksOrBetter85_TWO_PAIR = { TWO_PAIR, 2, 2*MAX_BET, &GamePayTable::CheckForTwoPair};
static const PayOutType JacksOrBetter85_THREE_OF_A_KIND = { THREE_OF_A_KIND, 3, 3*MAX_BET, &GamePayTable::CheckForThreeOfAKind};
static const PayOutType JacksOrBetter85_STRAIGHT = { STRAIGHT, 4, 4*MAX_BET, &GamePayTable::CheckForStraight};
static const PayOutType JacksOrBetter85_FLUSH = { FLUSH, 5, 5*MAX_BET, &GamePayTable::CheckForFlush};
static const PayOutType JacksOrBetter85_FULL_HOUSE = { FULL_HOUSE, 8, 8*MAX_BET, &GamePayTable::CheckForFullHouse};
static const PayOutType JacksOrBetter85_FOUR_OF_A_KIND = { FOUR_OF_A_KIND, 25, 25*MAX_BET, &GamePayTable::CheckForFourOfAKind};
static const PayOutType JacksOrBetter85_STRAIGHT_FLUSH = { STRAIGHT_FLUSH, 50, 50*MAX_BET, &GamePayTable::CheckForStraightFlush};
static const PayOutType JacksOrBetter85_ROYAL_FLUSH = { ROYAL_FLUSH, 250, 4000, &GamePayTable::CheckForRoyalFlush};

static const PayOutType JacksOrBetter85_PayTable[] = 
{ 
	JacksOrBetter85_ROYAL_FLUSH, 
	JacksOrBetter85_STRAIGHT_FLUSH,
	JacksOrBetter85_FOUR_OF_A_KIND,
	JacksOrBetter85_FULL_HOUSE,
	JacksOrBetter85_FLUSH,
	JacksOrBetter85_STRAIGHT,
	JacksOrBetter85_THREE_OF_A_KIND,
	JacksOrBetter85_TWO_PAIR,
	JacksOrBetter85_PAIR_JACKS_OR_BETTER 
};

static const PayOutType Bonus_PAIR_JACKS_OR_BETTER = { PAIR_JACKS_OR_BETTER, 1, 1*MAX_BET, &GamePayTable::CheckForJacksOrBetterPair};
static const PayOutType Bonus_TWO_PAIR = { TWO_PAIR, 2, 2*MAX_BET, &GamePayTable::CheckForTwoPair};
static const PayOutType Bonus_THREE_OF_A_KIND = { THREE_OF_A_KIND, 3, 3*MAX_BET, &GamePayTable::CheckForThreeOfAKind};
static const PayOutType Bonus_STRAIGHT = { STRAIGHT, 4, 4*MAX_BET, &GamePayTable::CheckForStraight};
static const PayOutType Bonus_FLUSH = { FLUSH, 5, 5*MAX_BET, &GamePayTable::CheckForFlush};
static const PayOutType Bonus_FULL_HOUSE = { FULL_HOUSE, 8, 8*MAX_BET, &GamePayTable::CheckForFullHouse};
static const PayOutType Bonus_FOUR_OF_A_KIND_ACES = { FOUR_OF_A_KIND_ACES, 80, 80*MAX_BET, &GamePayTable::CheckForFourOfAKindAces};
static const PayOutType Bonus_FOUR_OF_A_KIND_234 = { FOUR_OF_A_KIND_234, 40, 40*MAX_BET, &GamePayTable::CheckForFourOfAKind234};
static const PayOutType Bonus_FOUR_OF_A_KIND_5_TO_K = { FOUR_OF_A_KIND_5_TO_K, 25, 25*MAX_BET, &GamePayTable::CheckForFourOfAKind5ToK};
static const PayOutType Bonus_STRAIGHT_FLUSH = { STRAIGHT_FLUSH, 50, 50*MAX_BET, &GamePayTable::CheckForStraightFlush};
static const PayOutType Bonus_ROYAL_FLUSH = { ROYAL_FLUSH, 250, 4000, &GamePayTable::CheckForRoyalFlush};

static const PayOutType Bonus_PayTable[] = 
{ 
	Bonus_ROYAL_FLUSH, 
	Bonus_STRAIGHT_FLUSH,
	Bonus_FOUR_OF_A_KIND_ACES,
	Bonus_FOUR_OF_A_KIND_234,
	Bonus_FOUR_OF_A_KIND_5_TO_K,
	Bonus_FULL_HOUSE,
	Bonus_FLUSH,
	Bonus_STRAIGHT,
	Bonus_THREE_OF_A_KIND,
	Bonus_TWO_PAIR,
	Bonus_PAIR_JACKS_OR_BETTER 
};

static const PayOutType Double_Bonus_PAIR_JACKS_OR_BETTER = { PAIR_JACKS_OR_BETTER, 1, 1*MAX_BET, &GamePayTable::CheckForJacksOrBetterPair};
static const PayOutType Double_Bonus_TWO_PAIR = { TWO_PAIR, 1, 1*MAX_BET, &GamePayTable::CheckForTwoPair};
static const PayOutType Double_Bonus_THREE_OF_A_KIND = { THREE_OF_A_KIND, 3, 3*MAX_BET, &GamePayTable::CheckForThreeOfAKind};
static const PayOutType Double_Bonus_STRAIGHT = { STRAIGHT, 5, 5*MAX_BET, &GamePayTable::CheckForStraight};
static const PayOutType Double_Bonus_FLUSH = { FLUSH, 7, 7*MAX_BET, &GamePayTable::CheckForFlush};
static const PayOutType Double_Bonus_FULL_HOUSE = { FULL_HOUSE, 10, 10*MAX_BET, &GamePayTable::CheckForFullHouse};
static const PayOutType Double_Bonus_FOUR_OF_A_KIND_ACES = { FOUR_OF_A_KIND_ACES, 160, 160*MAX_BET, &GamePayTable::CheckForFourOfAKindAces};
static const PayOutType Double_Bonus_FOUR_OF_A_KIND_234 = { FOUR_OF_A_KIND_234, 80, 80*MAX_BET, &GamePayTable::CheckForFourOfAKind234};
static const PayOutType Double_Bonus_FOUR_OF_A_KIND_5_TO_K = { FOUR_OF_A_KIND_5_TO_K, 50, 50*MAX_BET, &GamePayTable::CheckForFourOfAKind5ToK};
static const PayOutType Double_Bonus_STRAIGHT_FLUSH = { STRAIGHT_FLUSH, 50, 50*MAX_BET, &GamePayTable::CheckForStraightFlush};
static const PayOutType Double_Bonus_ROYAL_FLUSH = { ROYAL_FLUSH, 250, 4000, &GamePayTable::CheckForRoyalFlush};

static const PayOutType Double_Bonus_PayTable[] = 
{ 
	Double_Bonus_ROYAL_FLUSH, 
	Double_Bonus_STRAIGHT_FLUSH,
	Double_Bonus_FOUR_OF_A_KIND_ACES,
	Double_Bonus_FOUR_OF_A_KIND_234,
	Double_Bonus_FOUR_OF_A_KIND_5_TO_K,
	Double_Bonus_FULL_HOUSE,
	Double_Bonus_FLUSH,
	Double_Bonus_STRAIGHT,
	Double_Bonus_THREE_OF_A_KIND,
	Double_Bonus_TWO_PAIR,
	Double_Bonus_PAIR_JACKS_OR_BETTER 
};

static const PayOutType Super_Aces_PAIR_JACKS_OR_BETTER = { PAIR_JACKS_OR_BETTER, 1, 1*MAX_BET, &GamePayTable::CheckForJacksOrBetterPair};
static const PayOutType Super_Aces_TWO_PAIR = { TWO_PAIR, 1, 1*MAX_BET, &GamePayTable::CheckForTwoPair};
static const PayOutType Super_Aces_THREE_OF_A_KIND = { THREE_OF_A_KIND, 3, 3*MAX_BET, &GamePayTable::CheckForThreeOfAKind};
static const PayOutType Super_Aces_STRAIGHT = { STRAIGHT, 4, 4*MAX_BET, &GamePayTable::CheckForStraight};
static const PayOutType Super_Aces_FLUSH = { FLUSH, 5, 5*MAX_BET, &GamePayTable::CheckForFlush};
static const PayOutType Super_Aces_FULL_HOUSE = { FULL_HOUSE, 8, 8*MAX_BET, &GamePayTable::CheckForFullHouse};
static const PayOutType Super_Aces_FOUR_OF_A_KIND_ACES = { FOUR_OF_A_KIND_ACES, 400, 400*MAX_BET, &GamePayTable::CheckForFourOfAKindAces};
static const PayOutType Super_Aces_FOUR_OF_A_KIND_234 = { FOUR_OF_A_KIND_234, 80, 80*MAX_BET, &GamePayTable::CheckForFourOfAKind234};
static const PayOutType Super_Aces_FOUR_OF_A_KIND_5_TO_K = { FOUR_OF_A_KIND_5_TO_K, 50, 50*MAX_BET, &GamePayTable::CheckForFourOfAKind5ToK};
static const PayOutType Super_Aces_STRAIGHT_FLUSH = { STRAIGHT_FLUSH, 60, 60*MAX_BET, &GamePayTable::CheckForStraightFlush};
static const PayOutType Super_Aces_ROYAL_FLUSH = { ROYAL_FLUSH, 250, 4000, &GamePayTable::CheckForRoyalFlush};

static const PayOutType Super_Aces_PayTable[] = 
{ 
	Super_Aces_ROYAL_FLUSH, 
	Super_Aces_STRAIGHT_FLUSH,
	Super_Aces_FOUR_OF_A_KIND_ACES,
	Super_Aces_FOUR_OF_A_KIND_234,
	Super_Aces_FOUR_OF_A_KIND_5_TO_K,
	Super_Aces_FULL_HOUSE,
	Super_Aces_FLUSH,
	Super_Aces_STRAIGHT,
	Super_Aces_THREE_OF_A_KIND,
	Super_Aces_TWO_PAIR,
	Super_Aces_PAIR_JACKS_OR_BETTER 
};

static const PayOutType* PayTables[] =
{
	JacksOrBetter96_PayTable,
	JacksOrBetter85_PayTable,
	TensOrBetter65_PayTable,	
	Bonus_PayTable,
	Double_Bonus_PayTable,
	Super_Aces_PayTable
};

static const int PayTablesSizes[] =
{
	sizeof(JacksOrBetter96_PayTable)/sizeof(PayOutType),
	sizeof(JacksOrBetter85_PayTable)/sizeof(PayOutType),
	sizeof(TensOrBetter65_PayTable)/sizeof(PayOutType),	
	sizeof(Bonus_PayTable)/sizeof(PayOutType),
	sizeof(Double_Bonus_PayTable)/sizeof(PayOutType),
	sizeof(Super_Aces_PayTable)/sizeof(PayOutType)
};
static const PayOutType INVALID_PAYOUTTYPE = { HIGHCARD, -1, -1, &GamePayTable::CheckForRoyalFlush};

GamePayTable::GamePayTable()
{
	currentPayTableType = PAYTABLE_JACKS_OR_BETTER_96;
	currentPayTable = PayTables[PAYTABLE_JACKS_OR_BETTER_96];
	
	sizeOfPayTable = sizeof(JacksOrBetter96_PayTable)/sizeof(PayOutType);
}
const int GamePayTable::getLargestPaytableSize()
{
	int retVal = PayTablesSizes[0];
	int bounds = sizeof(PayTablesSizes)/sizeof(int);
	for (int i = 0; i<bounds; i++) {
		retVal = (retVal > PayTablesSizes[i]) ? retVal : PayTablesSizes[i];
	}
	return retVal;
}
void GamePayTable::setCurrentPayTable(PayTableType pt) 
{ 
	currentPayTableType = pt;
	currentPayTable = PayTables[pt]; 
	sizeOfPayTable = PayTablesSizes[pt];

}
const PayOutType* GamePayTable::getPayTableByType(PayTableType pt)
{
	const PayOutType* pays;
	pays = PayTables[pt];
	return pays;
}

PayOutType  GamePayTable::determinePayout(vector<HandStat>& hs)
{
	PayOutType retVal = INVALID_PAYOUTTYPE;
	
#ifdef POKERPAD_TRACE_PAY_TABLES
	cout << "SIZE OF PAYTABLE IS: " << sizeOfPayTable << endl;
#endif
	for(int i = sizeOfPayTable-1; i >=0; i--)
	{	
		PayOutType tempPOT = currentPayTable[i];
		bool match = (*this.*(tempPOT.evaluatorEquation))(hs);
		if(match)
			retVal = currentPayTable[i];
#ifdef POKERPAD_TRACE_PAY_TABLES
		cout << "IS A " << AllHandTypeStrings[tempPOT.type] << " WIN? " << ((match == 0) ? "FALSE" : "TRUE") << endl;
#endif
	}
	return retVal;
}

int  GamePayTable::CheckForFourOfAKindValue(vector<HandStat>& hs)
{
	int retVal = -1;
	
	vector<HandStat>::iterator hstatiter;
	for(hstatiter = hs.begin(); 
		hstatiter != hs.end();
		hstatiter++)
	{
		if(hstatiter->positions.size() == 4)
		{
			for(int i = 0; i < hstatiter->positions.size(); i++)
			{
				CardGameModel::Instance()->winPositions.push_back(hstatiter->positions[i]);	
			}
			retVal = hstatiter->value;
			break;
		}
	}
	return retVal;
}
bool  GamePayTable::CheckForFourOfAKindAceDeuce(vector<HandStat>& hs)
{
	int fourOfAKindValue = CheckForFourOfAKindValue(hs);
	bool retVal = ((fourOfAKindValue == ACE_13) || (fourOfAKindValue == ACE) || (fourOfAKindValue == TWO));
	return retVal;
}
bool  GamePayTable::CheckForFourOfAKindAces(vector<HandStat>& hs)
{
	int fourOfAKindValue = CheckForFourOfAKindValue(hs);
	bool retVal = ((fourOfAKindValue == ACE_13) || (fourOfAKindValue == ACE));
	return retVal;
}
bool  GamePayTable::CheckForFourOfAKind234(vector<HandStat>& hs)
{
	int fourOfAKindValue = CheckForFourOfAKindValue(hs);
	bool retVal = ((fourOfAKindValue == TWO) || (fourOfAKindValue == THREE) || (fourOfAKindValue == FOUR));
	return retVal;
}
bool  GamePayTable::CheckForFourOfAKind5ToK(vector<HandStat>& hs)
{
	int fourOfAKindValue = CheckForFourOfAKindValue(hs);
	bool retVal = ((fourOfAKindValue >= FIVE) && (fourOfAKindValue <= KING));
	return retVal;
}
bool  GamePayTable::CheckForFourOfAKind(vector<HandStat>& hs)
{
	return (CheckForFourOfAKindValue(hs) != -1 ) ? true : false;
}

bool  GamePayTable::CheckForFullHouse(vector<HandStat>& hs)
{
	int cv;
	return (CheckForThreeOfAKind(hs) && CheckForPair(hs,&cv));
}
bool  GamePayTable::CheckForThreeOfAKind(vector<HandStat>& hs)
{
	bool retVal = false;
	vector<HandStat>::iterator hstatiter;
	for(hstatiter = hs.begin(); 
		hstatiter != hs.end();
		hstatiter++)
	{
		if(hstatiter->positions.size() == 3)
		{
			for(int i = 0; i < hstatiter->positions.size(); i++)
			{
				CardGameModel::Instance()->winPositions.push_back(hstatiter->positions[i]);	
			}
			retVal = true;
			break;
		}
	}
	return retVal;
}
bool  GamePayTable::CheckForTwoPair(vector<HandStat>& hs)
{
	
	bool retVal = false;
	bool onePair = false;
	vector<HandStat>::iterator hstatiter;
	for(hstatiter = hs.begin(); 
		hstatiter != hs.end();
		hstatiter++)
	{
		if(hstatiter->positions.size() == 2)
		{
			if(onePair == false)
			{
				for(int i = 0; i < hstatiter->positions.size(); i++)
				{
					CardGameModel::Instance()->winPositions.push_back(hstatiter->positions[i]);	
				}
				onePair = true;
			}
			else
			{
				for(int i = 0; i < hstatiter->positions.size(); i++)
				{
					CardGameModel::Instance()->winPositions.push_back(hstatiter->positions[i]);	
				}
				retVal = true;
				break;
			}
		}
	}
	return retVal;
}
bool  GamePayTable::CheckForStraightFlush(vector<HandStat>& hs)
{
	return CheckForFlush(hs) && CheckForStraight(hs);
}
bool  GamePayTable::CheckForRoyalFlush(vector<HandStat>& hs)
{
	bool retVal = false;
	if(CheckForFlush(hs))
	{
		vector<HandStat>::iterator hstatiter;
		for(hstatiter = hs.begin(); 
			hstatiter != hs.end();
			hstatiter++)
		{
			if((hstatiter->type == RUN) && (hstatiter->value == ACE_13))
			{
				CardGameModel::Instance()->winPositions.clear();
				for(int i = 0; i < 5; i++)
				{
					CardGameModel::Instance()->winPositions.push_back(i);	
				}
				retVal = true;
				
				break;
			}
		}
	}
	return retVal;
}
bool  GamePayTable::CheckForFlush(vector<HandStat>& hs)
{
	bool retVal = false;
	vector<HandStat>::iterator hstatiter;
	
	for(hstatiter = hs.begin(); 
		hstatiter != hs.end();
		hstatiter++)
	{
		if(hstatiter->type == CARDS_FLUSH)
		{
			CardGameModel::Instance()->winPositions.clear();
			for(int i = 0; i < 5; i++)
			{
				CardGameModel::Instance()->winPositions.push_back(i);	
			}
			retVal = true;
			break;
		}
	}
	return retVal;
}

bool  GamePayTable::CheckForStraight(vector<HandStat>& hs)
{
	
	bool retVal = false;
	vector<HandStat>::iterator hstatiter;
	for(hstatiter = hs.begin(); 
		hstatiter != hs.end();
		hstatiter++)
	{
		if(hstatiter->type == RUN)
		{	
			CardGameModel::Instance()->winPositions.clear();

			for(int i = 0; i < 5; i++)
			{
				CardGameModel::Instance()->winPositions.push_back(i);	
			}
			retVal = true;
			break;
		}
	}
	return retVal;
}

bool  GamePayTable::CheckForJacksOrBetterPair(vector<HandStat>& hs)
{
	bool retVal = false;
	int pairValue = -1;
	if( CheckForPair(hs, &pairValue))
	{
		if(pairValue >= JACK)
		{			
			retVal = true;
		}
		else if(pairValue == ACE)
		{
			retVal = true;
		}
	}
	return retVal;
}
bool  GamePayTable::CheckForTensOrBetterPair(vector<HandStat>& hs)
{
	bool retVal = false;
	int pairValue = -1;
	if( CheckForPair(hs, &pairValue))
	{
		if(pairValue >= TEN)
		{
			retVal = true;
		}
		else if(pairValue == ACE)
		{
			retVal = true;
		}

	}
	return retVal;
}

bool  GamePayTable::CheckForPair(vector<HandStat>& hs, int* cv)
{
	bool retVal = false;
	vector<HandStat>::iterator hstatiter;
	for(hstatiter = hs.begin(); 
		hstatiter != hs.end();
		hstatiter++)
	{
		if(hstatiter->positions.size() == 2)
		{
			*cv = hstatiter->value;
			for(int i = 0; i < hstatiter->positions.size(); i++)
			{
				CardGameModel::Instance()->winPositions.push_back(hstatiter->positions[i]);	
			}
			retVal = true;
			break;
		}
	}
	return retVal;
}



