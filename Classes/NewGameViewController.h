//
//  NewGameViewController.h
//  iPadVideoPoker
//
//  Created by Robert Diel on 4/15/10.
//  Copyright 2016 Robert Diel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaveUserState.h"
#import "GameSelectionView.h"


@interface NewGameViewController : UIViewController {
	SaveUserState* saveState;
	UIImageView* horzBkg;
	UIImageView* vertBkg;
	GameSelectionView* gameSelectionView;
	CGPoint gameSelectionViewVertOrigin;
	CGPoint gameSelectionViewHorzOrigin;


}
@property (nonatomic, retain)  IBOutlet UIImageView* horzBkg;
@property (nonatomic, retain)  IBOutlet UIImageView* vertBkg;
@property (nonatomic, retain)  IBOutlet GameSelectionView* gameSelectionView;
-(void)displayHorizontalOrientation:(BOOL)yesOrNo;

@end
