/*
 *  iPadVideoPokerDefs.h
 *  iPadVideoPoker
 *
 *  Created by Robert Diel on 4/11/10.
 *  Copyright 2016 Robert Diel. All rights reserved.
 *
 */

//Turn this off if you want to disable the ability to save the game state.
#define SAVE_STATE

//Set the initial wallet value is also the reload value
#define INITIAL_WALLET 100

struct ViewOriginPoint {
	CGPoint origin;
	UIView* view;
	
	void populate(UIView* v,int x, int y) {origin.x = x; origin.y = y; view = v;};
};

