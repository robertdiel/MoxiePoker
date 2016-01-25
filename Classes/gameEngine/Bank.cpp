/*
 *  Bank.cpp
 *  videopoker
 *
 *  Created by Robert Diel on 12/21/08.
 *  Copyright 2016 Robert Diel. All rights reserved.
 *
 */

#include "Bank.h"

void Bank::deposit(int value)
{
	accountValue += value;
}
bool Bank::escrowCash(int value)
{
	bool retVal = false;
	if((int)(accountValue - value) >= 0)
	{
		escrow += value;
		accountValue -= value;
		retVal = true;
	}
	return retVal;
}
unsigned int Bank::getAccountValue()
{
	return accountValue;
}
void Bank::spendEscrow()
{
	escrow = 0;
}