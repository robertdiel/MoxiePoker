/*
 *  PlayingCard.cpp
 *  videopoker
 *
 *  Created by Robert Diel on 11/6/08.
 *  Copyright 2016 Robert Diel. All rights reserved.
 *
 */

#include "PlayingCard.h"
#include <iostream>

PlayingCard::PlayingCard()
{
}
int PlayingCard::operator<(const PlayingCard &InputCard) const
{
	if(InputCard.val <= this->val)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}
bool PlayingCard::cmp(const PlayingCard* a)
{
    return a->val <= this->val;
}
PlayingCard::PlayingCard(CardSuit s,CardValue v)
{
	suit =   s;
	val = v;
}


PlayingCard::PlayingCard(string shortSuitCode, string shortValCode)
{
	
	for (int i = 0; i< LASTCARDSUIT; i++) 
	{
		if (shortSuitCode == suithalf[i]) 
		{
			suit = (CardSuit)i;
			break;
		}
	}
	
	for (int j = 0; j< LASTCARDVALUE; j++) 
	{
		if (shortValCode == valhalf[j]) 
		{
			val = (CardValue)j;
			break;
		}
	}
}

CardSuit PlayingCard::getSuit()
{
	return suit;
	
}

CardValue PlayingCard::getValue()
{
	return val;
}

string PlayingCard::toString(CardSuit s, CardValue v)
{
	string retVal = ValueString[v] + " " + SuitString[s]+"S";
	return retVal;
}

string PlayingCard::toString()
{
	string retVal = ValueString[val] + " " + SuitString[suit]+"S";
	return retVal;
}
 
ostream& operator<<(ostream &os,const PlayingCard &InputCard )
{
	os<<ValueString[InputCard.val] << " of " << SuitString[InputCard.suit] << "s";
	return os;
}

string PlayingCard::getCardShortName()
{
	return string(suithalf[suit] + valhalf[val]);
}
