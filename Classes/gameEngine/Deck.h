/*
 *  Deck.h
 *  videopoker
 *
 *  Created by Robert Diel on 11/19/08.
 *  Copyright 2016 Robert Diel. All rights reserved.
 *
 */
#ifndef __DECK_H
#define __DECK_H
#include "PlayingCard.h"
#include <string>
#include <vector>
#include <iostream>

using namespace std;
class Deck
{
		
private:
	vector<PlayingCard*> cards;
	vector<PlayingCard*> savedCards;
	int currentPosition;
	string exception;
	
public:
	Deck();
	
	void shuffle();

	PlayingCard* getNextCard();		
	string getException();		
	void traceDeck();	
	int getSuitCount(CardSuit whichSuit);
	int getValueCount(CardValue whichValue);
	string compressCardsToString(int howMany);
	void uncompressStringToCards(int howMany, const char* cardString);
	void clearOutSavedDeck();

};
#endif