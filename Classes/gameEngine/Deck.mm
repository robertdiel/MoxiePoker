/*
 *  Deck.c
 *  videopoker
 *
 *  Created by Robert Diel on 11/19/08.
 *  Copyright 2016 Robert Diel. All rights reserved.
 *
 */

#include "Deck.h"
#include <algorithm>

//#define POKERPAD_TRACE_DECK

Deck::Deck()
{
#ifdef POKERPAD_TRACE_DECK
    cout << "deck.deck" << endl;
#endif
	
	//seed the random number generator with the current time.
	srand ( unsigned ( time (NULL) ) );
	
	currentPosition = 0;
	exception = "None";
	

	for(int j = TWO; j < LASTCARDVALUE; j++)
	{
		for(int i = HEART; i<LASTCARDSUIT; i++)
		{
			PlayingCard* tempCard = new PlayingCard((CardSuit)i,(CardValue)j);
			cards.insert(cards.begin(),tempCard);
		}
	}
    
#ifdef POKERPAD_TRACE_DECK
	traceDeck();
#endif
}
void Deck::shuffle()
{
#ifdef POKERPAD_TRACE_DECK
	cout << "deck.shuffle" << endl;
#endif
    random_shuffle(cards.begin(), cards.end());
	random_shuffle(cards.begin(), cards.end());
	random_shuffle(cards.begin(), cards.end());
	random_shuffle(cards.begin(), cards.end());
	random_shuffle(cards.begin(), cards.end());
	random_shuffle(cards.begin(), cards.end());
	random_shuffle(cards.begin(), cards.end());
	currentPosition = 0;
    
#ifdef POKERPAD_TRACE_DECK
    traceDeck();
#endif
}
PlayingCard* Deck::getNextCard()
{
    
#ifdef POKERPAD_TRACE_DECK
	cout << "deck.getNextCard" << endl;
#endif

	PlayingCard* retCard;
	
	vector<PlayingCard*> tempCards = (savedCards.size() == 0) ? cards : savedCards;
	//if you go beyond the end of the deck reshuffle, and get the top card.
	//   In C++ this would be the perfect place to throw an exception.
	if(currentPosition >= tempCards.size())
	{
		exception = "RESHUFFLE";
		shuffle();
		currentPosition = 0;
		retCard = tempCards[currentPosition];
	}
	else
	{			
		retCard = tempCards[currentPosition++];
	}
	return retCard;
}

string Deck::getException()
{
	return exception;
}

void Deck::traceDeck()
{
	vector<PlayingCard*>::iterator mycarditr;
	int i = 0;
	for(mycarditr = cards.begin(); 
		mycarditr != cards.end();
		mycarditr++)
	{
		cout<<(i++)<<": " <<**mycarditr<<endl;
	}
}
int Deck::getSuitCount(CardSuit whichSuit)
{
	int suitCounter = 0;
	vector<PlayingCard*>::iterator mycarditr;
	for(mycarditr = cards.begin(); 
		mycarditr != cards.end();
		mycarditr++)
	{
		if((*mycarditr)->getSuit() == whichSuit)
			suitCounter++;
	}
	return suitCounter;
}

int Deck::getValueCount(CardValue whichValue)
{
	int valueCounter = 0;
	vector<PlayingCard*>::iterator mycarditr;
	for(mycarditr = cards.begin(); 
		mycarditr != cards.end();
		mycarditr++)
	{
		if((*mycarditr)->getValue() == whichValue)
			valueCounter++;
	}
	return valueCounter;
}

string Deck::compressCardsToString(int howMany)
{
	string cardString;
	
	vector<PlayingCard*>::iterator mycarditr = cards.begin();
	while(mycarditr < cards.end())
	{
		if((howMany--) == 0)
			break;
		cardString += ((PlayingCard*)(*mycarditr))->getCardShortName();
		mycarditr++;
	}
	return cardString;
}

void Deck::uncompressStringToCards(int howMany, const char* cardString)
{
	string suitVal;
	string cardVal;
	
	int j = 0;
	for (int i = 0; i < howMany; i++) 
	{
		suitVal = cardString[j++];
		cardVal = cardString[j++];
		PlayingCard* tempCard = new PlayingCard(suitVal,cardVal);
        
#ifdef POKERPAD_TRACE_DECK
        cout << *tempCard << endl;
#endif
		savedCards.push_back(tempCard);
	}

}

void Deck::clearOutSavedDeck()
{
	savedCards.clear();
}
