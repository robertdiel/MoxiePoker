/*
 *  CardImageFactory.h
 *  videopoker
 *
 *  Created by Robert Diel on 11/20/08.
 *  Copyright 2016 Robert Diel. All rights reserved.
 *
 */
#ifndef __CARDIMAGEFACTORY_H
#define __CARDIMAGEFACTORY_H

#include "PlayingCard.h"
#include <string>


class CardImageFactory
{
	
public:
	CardImageFactory(){};
	static string getImageNameByCard(  PlayingCard& pc);
	static string getValString( PlayingCard& pc);

private:
	static string getImageStringByValue(CardValue cv);

};

#endif
