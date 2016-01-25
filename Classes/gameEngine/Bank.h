/*
 *  Bank.h
 *  videopoker
 *
 *  Created by Robert Diel on 12/21/08.
 *  Copyright 2016 Robert Diel. All rights reserved.
 *
 */
#ifndef __Bank_H
#define __Bank_H
class Bank
{
private:
	unsigned int accountValue;
	unsigned int escrow;
public:
	Bank(){accountValue = 0; escrow = 0;}
	void deposit(int value);
	bool escrowCash(int value);
	unsigned int getAccountValue();
	void spendEscrow();
};
#endif