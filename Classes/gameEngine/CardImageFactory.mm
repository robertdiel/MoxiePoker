/*
 *  CardImageFactory.cpp
 *  videopoker
 *
 *  Created by Robert Diel on 11/20/08.
 *  Copyright 2016 Robert Diel. All rights reserved.
 *
 */

#include "CardImageFactory.h"
string CardImageFactory::getImageNameByCard(  PlayingCard& pc)
{
	string retVal;
	//return suithalf[pc.getSuit()] + valhalf[pc.getValue()] + ".png";
	switch (pc.getSuit()) 
	{
		case HEART:
			retVal = "card_heart_"+CardImageFactory::getImageStringByValue(pc.getValue());
			break;
		case SPADE:
			retVal = "card_spade_"+CardImageFactory::getImageStringByValue(pc.getValue());
			break;
		case DIAMOND:
			retVal = "card_diamond_"+CardImageFactory::getImageStringByValue(pc.getValue());
			break;
		case CLUB:
			retVal = "card_club_"+CardImageFactory::getImageStringByValue(pc.getValue());
			break;
		default:
			break;
	}
	return retVal;
}

string CardImageFactory::getImageStringByValue(CardValue cv)
{
	string retVal;
	switch (cv) 
	{
		case JACK:
			retVal = "jack.png";
			break;
		case QUEEN:
			retVal = "queen.png";
			break;
		case KING:
			retVal = "king.png";
			break;
		default:
			retVal = "generic.png";
			break;
	}
	return retVal;
}
string CardImageFactory::getValString(  PlayingCard& pc)
{
	return (valhalf[pc.getValue()] == "t") ? "10" : valhalf[pc.getValue()];
}