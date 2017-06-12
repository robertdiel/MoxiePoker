/*
 *  Hand.h
 *  videopoker
 *
 *  Created by Robert Diel on 12/1/08.
 *  Copyright 2016 Robert Diel. All rights reserved.
 *
 */
#ifndef __HAND_H
#define __HAND_H
#include "PlayingCard.h"
#include <vector>
#include "Deck.h"

using namespace std;

//#define UNITTEST_HANDS

class Hand
{
	vector<PlayingCard> HandOfCards;
	int NumberOfCards;
	Deck* WhichDeck;

public:
	Hand(int inNumberOfCards, Deck* inWhichDeck);
	Hand();
	~Hand();
	PlayingCard& readCard(int i);
	int getNumberOfCards(){return NumberOfCards;};
	void DebugPrintOut();
	void ReplaceCardWithOneFromDeck(int position);
};

#ifdef UNITTEST_HANDS
class HandUnitTester
{
public:
	static HandUnitTester* Instance();

	
	PlayingCard* getNextUnitTestHand();
private:
	static HandUnitTester* pinstance;
	
	static int currentHand;
    static PlayingCard randoHando[5];
	static PlayingCard straightArray[5];
	static PlayingCard straightFlushArray[5];	
	static PlayingCard flushArray[5];
	static PlayingCard royalFlushArray[5];
	static PlayingCard fourOfAKindArray[5];
	static PlayingCard threeOfAKindArray[5];
	static PlayingCard fullHouseArray[5];
	static PlayingCard twoPairArray[5];
	static PlayingCard jacksOrBetterArray[5];
	
	static PlayingCard* unitTestArray[];		
};
#endif

#endif
