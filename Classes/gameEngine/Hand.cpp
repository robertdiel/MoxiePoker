/*
 *  Hand.cpp
 *  videopoker
 *
 *  Created by Robert Diel on 12/1/08.
 *  Copyright 2016 Robert Diel. All rights reserved.
 *
 */
#include "Hand.h"
#include <algorithm>
#include <iostream>
#include <vector>
#include "Deck.h"


#define POKERPAD_TRACE_HAND

Hand::Hand(int inNumberOfCards,Deck* inWhichDeck)
{
	WhichDeck = inWhichDeck;
#ifdef UNITTEST_HANDS
	PlayingCard* tempHand = HandUnitTester::Instance()->getNextUnitTestHand();
	for (int i = 0; i < 5; i++)
	{
		HandOfCards.push_back(tempHand[i]);
	}
	NumberOfCards=5;
#else
	NumberOfCards=inNumberOfCards;
	for(int i = 0; i < NumberOfCards; i++)
	{
		PlayingCard* tempCard;
		tempCard = WhichDeck->getNextCard();
		HandOfCards.insert(HandOfCards.begin(),*tempCard);
		/*
		//Remove to look at hand
		cout << i << ": ";
		cout << tempCard.getValueString() << " of " << tempCard.getSuitString() << endl;
		*/

	}
#endif
    
#ifdef POKERPAD_TRACE_HAND
	cout << "PRINT OUT HAND: " << endl;
	DebugPrintOut();
#endif
}
	


Hand::Hand()
{
	NumberOfCards =0;
}

Hand::~Hand()
{
	HandOfCards.clear();
}


void Hand::ReplaceCardWithOneFromDeck(int position)
{
	vector<PlayingCard*>::iterator mycarditr;
	//HandOfCards.erase(mycarditr+position);
	HandOfCards.erase(HandOfCards.begin()+(position));
	PlayingCard* tempCard;
	tempCard = WhichDeck->getNextCard();
	HandOfCards.insert(HandOfCards.begin()+(position),*tempCard);
}

PlayingCard& Hand::readCard(int i)
{
	if((i <= NumberOfCards) && (i > 0))
	{
		return (HandOfCards[i-1]);
	}
	
	return (PlayingCard&)HandOfCards[0];
	
}

void Hand::DebugPrintOut()
{
	cout << "HAND: ";
	for(int i = 0; i < NumberOfCards; i++)
	{
		cout <<  i << ": " <<  (HandOfCards[i]);
	}
	cout << endl;
}

#ifdef UNITTEST_HANDS
PlayingCard HandUnitTester::randoHando[5]      = {PlayingCard(DIAMOND,ACE_13), PlayingCard(CLUB, TWO),PlayingCard(CLUB,NINE),PlayingCard(HEART,QUEEN),PlayingCard(CLUB,KING)};

PlayingCard HandUnitTester::straightArray[5]      = {PlayingCard(DIAMOND,FOUR), PlayingCard(CLUB, TWO),PlayingCard(CLUB,ACE_13),PlayingCard(CLUB,THREE),PlayingCard(CLUB,FIVE)};
PlayingCard HandUnitTester::flushArray[5]         = {PlayingCard(CLUB,SEVEN), PlayingCard(CLUB, TWO),PlayingCard(CLUB,ACE_13),PlayingCard(CLUB,THREE),PlayingCard(CLUB,FIVE)};
PlayingCard HandUnitTester::straightFlushArray[5] = {PlayingCard(CLUB,FOUR), PlayingCard(CLUB, TWO),PlayingCard(CLUB,ACE_13),PlayingCard(CLUB,THREE),PlayingCard(CLUB,FIVE)};
PlayingCard HandUnitTester::royalFlushArray[5]    = {PlayingCard(CLUB,TEN), PlayingCard(CLUB, JACK),PlayingCard(CLUB,ACE_13),PlayingCard(CLUB,QUEEN),PlayingCard(CLUB,KING)};
PlayingCard HandUnitTester::fourOfAKindArray[5]   = {PlayingCard(CLUB,TEN), PlayingCard(SPADE, TEN),PlayingCard(HEART,TEN),PlayingCard(DIAMOND,TEN),PlayingCard(CLUB,KING)};
PlayingCard HandUnitTester::threeOfAKindArray[5]  = {PlayingCard(CLUB,TEN), PlayingCard(SPADE, TEN),PlayingCard(HEART,TEN),PlayingCard(CLUB,QUEEN),PlayingCard(CLUB,KING)};
PlayingCard HandUnitTester::twoPairArray[5]       = {PlayingCard(CLUB,ACE_13), PlayingCard(CLUB, JACK),PlayingCard(HEART,ACE_13),PlayingCard(HEART,JACK),PlayingCard(CLUB,KING)};
PlayingCard HandUnitTester::fullHouseArray[5]     = {PlayingCard(CLUB,ACE_13), PlayingCard(SPADE, ACE_13),PlayingCard(HEART,ACE_13),PlayingCard(CLUB,TWO),PlayingCard(HEART,TWO)};
PlayingCard HandUnitTester::jacksOrBetterArray[5] = {PlayingCard(CLUB,TEN), PlayingCard(CLUB, JACK),PlayingCard(HEART,JACK),PlayingCard(CLUB,QUEEN),PlayingCard(CLUB,KING)};
PlayingCard* HandUnitTester::unitTestArray[]      = {randoHando, royalFlushArray, royalFlushArray, straightFlushArray, straightArray, flushArray, fourOfAKindArray, fullHouseArray,threeOfAKindArray,twoPairArray,jacksOrBetterArray };
#define sizeOF_unitTestArray sizeof(HandUnitTester::unitTestArray) / sizeof(PlayingCard*)

HandUnitTester* HandUnitTester::pinstance = 0;// initialize pointer
int HandUnitTester::currentHand = 0;

HandUnitTester* HandUnitTester::Instance () 
{
    if (pinstance == 0)  // is it the first call?
    {  
		//currentHand = 0;
		pinstance = new HandUnitTester; // create sole instance
    }
    return pinstance; // address of sole instance
}

PlayingCard* HandUnitTester::getNextUnitTestHand()
{
	//return (PlayingCard*) straightArray;
	PlayingCard* retHand =  HandUnitTester::unitTestArray[currentHand];
	currentHand++;
	cout << "SIZE OF UNITTEST ARRAY: " << sizeOF_unitTestArray << endl;
	if(currentHand >= sizeOF_unitTestArray) 
		currentHand = 0;
	return retHand;
}
#endif
