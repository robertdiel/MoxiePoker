/*
 *  Evaluator.cpp
 *  videopoker
 *
 *  Created by Robert Diel on 12/1/08.
 *  Copyright 2016 Robert Diel. All rights reserved.
 *
 */

#include "Evaluator.h"
#include "CardGameModel.h"

#define POKERPAD_TRACE_EVALUATION


Evaluator* Evaluator::pinstance = 0;

Evaluator* Evaluator::Instance () 
{
    if (pinstance == 0)
    {
		pinstance = new Evaluator;
    }
    return pinstance;
}
Evaluator::Evaluator() 
{ 
}

void Evaluator::Destroy()
{
	delete pinstance;
	pinstance=0;
}



vector<HandStat>& Evaluator::buildHandStats(Hand& handToEval)
{
	
    stats.clear();
    
	//build set handstat
	//build flush handstat
	vector<CardValue> vectorOfCV;
	for(int i = 1; i <= handToEval.getNumberOfCards(); i++)
	{
		CardValue cv;
		PlayingCard& pc = handToEval.readCard(i);
		cv = pc.getValue();
		vectorOfCV.push_back(cv);
	}
	
	vector<CardSuit> vectorOfCS;
	for(int i = 1; i <= handToEval.getNumberOfCards(); i++)
	{
		CardSuit cs;
		PlayingCard& pc = handToEval.readCard(i);
		cs = pc.getSuit();
		vectorOfCS.push_back(cs);
	}
	
	buildSetsHandStat(vectorOfCV);
	
	buildRunHandStat(vectorOfCV);
	
	buildFlushHandStat(vectorOfCS);
	CardGameModel::Instance()->convertHandStatsToWin(stats);
	vector<HandStat>::iterator hstatiter;
    
#ifdef POKERPAD_TRACE_EVALUATION
	cout << CardGameModel::Instance()->winType << endl;
    outputStats();
#endif
	return stats;
}
void Evaluator::outputStats()
{
	cout << "HANDSTATS: " << endl;
	vector<HandStat>::iterator hstatiter;
	for(hstatiter = stats.begin(); 
		hstatiter != stats.end();
		hstatiter++)
	{
		cout << "    " << *hstatiter << endl;
	}
}
void Evaluator::buildRunHandStat(vector<CardValue>& cardvalues)
{
	
	vector<CardValue> tempCardValueVector = cardvalues;
	
	vector<CardValue>::iterator mycarditr=tempCardValueVector.begin();

	sort(tempCardValueVector.begin(),tempCardValueVector.end());
	
	if(*(mycarditr+4) == ACE_13)
	{
		if(*(mycarditr) == TWO)
		{
			tempCardValueVector.insert(mycarditr,ACE);
			tempCardValueVector.erase(tempCardValueVector.end());
		}
	}
	mycarditr=tempCardValueVector.begin();
	
	CardValue checkCardValue = *mycarditr;
	int i = 1;
    
#ifdef POKERPAD_TRACE_EVALUATION
	cout << "BuildRun: " << endl;
#endif
    
	for(mycarditr = tempCardValueVector.begin()+1;
		mycarditr != tempCardValueVector.end();
		mycarditr++)
	{
		i++;
#ifdef POKERPAD_TRACE_EVALUATION
		cout << *mycarditr << "    ";
#endif
		checkCardValue = (CardValue)((int)checkCardValue + 1);
		if(checkCardValue != *mycarditr)
		{
			break;
		}
	}
#ifdef POKERPAD_TRACE_EVALUATION
	cout << endl;
#endif
    
    
    
	if(mycarditr == tempCardValueVector.end())
	{
		HandStat* newHandStat = new HandStat();
		
		newHandStat->type = RUN;
		newHandStat->value = checkCardValue;
		for(int k=0; k<tempCardValueVector.size(); k++)
		{
			newHandStat->positions.push_back(k);
		}
		stats.push_back(*newHandStat);
	}
	
}
void Evaluator::buildFlushHandStat(vector<CardSuit>& cardsuits )
{
	vector<CardSuit>::iterator mycarditr=cardsuits.begin();
	
	CardSuit checkCardSuit = *mycarditr;
	int i = 1;
#ifdef POKERPAD_TRACE_EVALUATION
	cout << "BuildFlush: " << endl;
#endif
	for(mycarditr = cardsuits.begin()+1;
		mycarditr != cardsuits.end();
		mycarditr++)
	{
#ifdef POKERPAD_TRACE_EVALUATION
		cout << "FLUSH: " << *mycarditr << endl;
#endif
		i++;
		if(checkCardSuit != *mycarditr)
		{
			break;
		}
	}
	if(mycarditr == cardsuits.end())
	{
		HandStat* newHandStat = new HandStat();
		
		newHandStat->type = CARDS_FLUSH;
		newHandStat->value = checkCardSuit;
		for(int k=0; k<cardsuits.size(); k++)
		{
			newHandStat->positions.push_back(k);
		}
		stats.push_back(*newHandStat);
	}
	
}
void Evaluator::buildSetsHandStat(vector<CardValue>& cardvalues )
{
	vector<CardValue>::iterator mycarditr;
	
	int i = 0;
	int j = 0;
#ifdef POKERPAD_TRACE_EVALUATION
	cout << "BuildSets: " << endl;
#endif
	for(mycarditr = cardvalues.begin();
		mycarditr != cardvalues.end();
		mycarditr++)
	{
		
		vector<CardValue>::iterator innerItr;
		vector<int> tempP;
		int matchcount = 0;
		for(innerItr = cardvalues.begin(); 
			innerItr != cardvalues.end();
			innerItr++)
		{
			
			if(*mycarditr == *innerItr)
			{
				matchcount++;
				tempP.push_back(j);
			}
			j++;
		}
		if(matchcount > 1)
		{
#ifdef POKERPAD_TRACE_EVALUATION
            cout << "SET of " << matchcount << " " << *mycarditr << endl;
#endif
			//if we don't have a handstat for that number make one
			if(handStatSetExists(*mycarditr)==false)
			{
				HandStat* newHandStat = new HandStat();
				
				newHandStat->value = *mycarditr;
				newHandStat->type = SET;
				
				vector<int>::iterator posIter;
				
				for(posIter = tempP.begin(); 
					posIter != tempP.end();
					posIter++)
				{
					newHandStat->positions.push_back(*posIter);
				}
				stats.push_back(*newHandStat);
			}
		}
		i++;
		j = 0;
	}
}

bool Evaluator::handStatSetExists(CardValue val)
{
	bool retVal = false;
	vector<HandStat>::iterator hstatiter;
	for(hstatiter = stats.begin(); 
		hstatiter != stats.end();
		hstatiter++)
	{
		if(hstatiter->value == val)
		{
			retVal = true;
			break;
		}
	}
	return retVal;
}

ostream& operator<<(ostream &os,const HandStat &InputStat )
{
	os<< InputStat.type << " of " << InputStat.value << " positions: " ;

	for(int i = 0; i < InputStat.positions.size(); i++)
    {
		os << InputStat.positions[i] << ",";
    }
	return os;
}

