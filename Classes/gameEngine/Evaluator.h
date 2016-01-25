/*
 *  Evaluator.h
 *  videopoker
 *
 *  Created by Robert Diel on 12/1/08.
 *  Copyright 2016 Robert Diel. All rights reserved.
 *
 */
#ifndef __EVALUATOR_H
#define __EVALUATOR_H
#include <vector>
#include "Hand.h"
#include "PlayingCard.h"

using namespace std;

	enum HandStatType
	{
		SET,
		RUN,
		CARDS_FLUSH,
		FLUSH_RUN
	};

class HandStat 
{
public:

	
	HandStat(){};
	
	HandStatType type;
	int value;
	vector<int> positions;
	
	friend ostream& operator<<(ostream &os, const HandStat &p);
};

class Evaluator 
{
public:
	static Evaluator* Instance();
	vector<HandStat>& buildHandStats(Hand& handToEval);
	void outputStats();
	
protected:
	Evaluator();
	Evaluator(const Evaluator&);
	Evaluator& operator= (const Evaluator&);
	void Destroy();
private:
	static Evaluator* pinstance;
	vector<HandStat> stats; 
	void buildSetsHandStat(vector<CardValue>& cardvalues );
	bool handStatSetExists(CardValue val);
	
	void buildFlushHandStat(vector<CardSuit>& cardsuits);
	void buildRunHandStat(vector<CardValue>& cardvalues);	
};
#endif