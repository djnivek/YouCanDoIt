//
//  ViewControllerGame.h
//  jeuBoire
//
//  Created by Kévin MACHADO on 14/01/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerGame : UIViewController <UIAlertViewDelegate>
{
    IBOutlet UILabel *userNameLabel;
    	
    IBOutlet UITextView *questionsField;
    IBOutlet UITextView *answerField;
    
    /**     GAGE    **/
    IBOutlet UITextView *gageField;
    IBOutlet UIButton *acceptButton;
    IBOutlet UIButton *refuseButton;
    
    NSMutableArray *players;
    NSMutableArray *questions;
    NSMutableArray *answers;
    NSMutableDictionary *gages;
    
    int currentPlayer;
    int currentQuestion;
    
    int second;
    
    NSTimer *timerSecondCounter;
    
    IBOutlet UILabel *secondCount;
    
    int countQ;
}

- (IBAction)acceptGage:(id)sender;
- (IBAction)refuseGage:(id)sender;

@end
