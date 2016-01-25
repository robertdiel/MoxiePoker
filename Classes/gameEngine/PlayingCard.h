/*
 *  PlayingCard.h
 *  videopoker
 *
 *  Created by Robert Diel on 11/6/08.
 *  Copyright 2016 Robert Diel. All rights reserved.
 *
 */

#ifndef __PlayingCard_H
#define __PlayingCard_H

#include <string>
#include <iostream>

using namespace std;

enum CardSuit { HEART, SPADE, DIAMOND, CLUB, LASTCARDSUIT };
enum CardValue { ACE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN, JACK, QUEEN, KING, ACE_13, LASTCARDVALUE };

const string SuitString[] = {"HEART", "SPADE", "DIAMOND", "CLUB" };
const string ValueString[14] = {"ACE_1", "TWO", "THREE", "FOUR", "FIVE", "SIX", "SEVEN", "EIGHT", "NINE", "TEN", "JACK", "QUEEN", "KING", "ACE_13" };

const string suithalf[] = {"h", "s", "d", "c" };
const string valhalf[] = {"a", "2", "3", "4", "5", "6", "7", "8", "9", "t", "j", "q", "k", "a" };

class PlayingCard
{
	public:
	CardSuit suit;
	CardValue val;
	friend ostream& operator<<(ostream &os, const PlayingCard &p);
	
	public:
		PlayingCard();
		PlayingCard(CardSuit s,CardValue v);  
		PlayingCard(string shortSuitCode, string shortValCode);
		CardSuit getSuit();
		CardValue getValue();
	
	
		int operator==(const PlayingCard &InputCard) const
		{
			if( (InputCard.val == this->val) &&
			   (InputCard.suit  == this->suit))
				return 1;
			else
				return 0;
		}
		int operator<(const PlayingCard &InputCard) const;
		bool cmp(const PlayingCard* a);
		string getCardShortName();
		string toString(CardSuit s, CardValue v);
		string toString();
};


#endif