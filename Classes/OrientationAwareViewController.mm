    //
//  OrientationAwareViewController.m
//  iPadVideoPoker
//
//  Created by Robert Diel on 4/12/10.
//  Copyright 2010 Moxie Post. All rights reserved.
//

#import "OrientationAwareViewController.h"


@implementation OrientationAwareViewController
@synthesize horizontalController;
@synthesize verticalController;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	horizontalController = [[HorizontaliPadVideoPokerViewController alloc] initWithNibName:@"HorizontaliPadVideoPokerViewController" bundle:nil];
	verticalController = [[iPadVideoPokerViewController alloc] initWithNibName:@"iPadVideoPokerViewController" bundle:nil];
	[self.view addSubview:horizontalController.view];
	[self.view addSubview:verticalController.view];
	horizontalController.view.hidden = false;
	[super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
	//return UIInterfaceOrientationIsPortrait(interfaceOrientation);
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    // no popouts for lanscape orientation (use the MasterViewController's table)
    //
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
    {
		//HorizontaliPadVideoPokerViewController* horizontalController = [[HorizontaliPadVideoPokerViewController alloc] initWithNibName:@"HorizontaliPadVideoPokerViewController" bundle:nil];
		//[self.view addSubview:vc.view];
		//[self.view addSubview:horizontalController.view];
		verticalController.view.hidden = true;
		horizontalController.view.hidden = false;

        //[self.navBar.topItem setLeftBarButtonItem:nil animated:NO];
		//self.view.alpha = 0;
    }
	else 
	{
		//[self.view addSubview:verticalController.view];
		verticalController.view.hidden = false;
		horizontalController.view.hidden = true;
	}
	
}
//	GrowlerAppDelegate* gad = ((GrowlerAppDelegate *)[UIApplication sharedApplication].delegate);

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
