//
//  ViewControllerGame.h
//  jeuBoire
//
//  Created by Kévin MACHADO on 14/01/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameSession;
@class QuestionReponse;

@interface ViewControllerGame : UIViewController <UIAlertViewDelegate>
{
    IBOutlet UILabel *userNameLabel;

    IBOutlet UILabel *questionField;
    
    IBOutlet UILabel *answerFieldA;
    IBOutlet UILabel *answerFieldB;
    IBOutlet UILabel *answerFieldC;
    IBOutlet UILabel *answerFieldD;
    
    IBOutlet UIButton *btnAnswerA;
    IBOutlet UIButton *btnAnswerB;
    IBOutlet UIButton *btnAnswerC;
    IBOutlet UIButton *btnAnswerD;
    
    /**     GAGE    **/
    IBOutlet UILabel *gageField;
    IBOutlet UIButton *acceptButton;
    IBOutlet UIButton *refuseButton;
    
    NSMutableDictionary *gages;
    
    GameSession *game;
    
    NSTimer *timerSecondCounter;
    NSTimer *timerDurationQuestion;
    
    IBOutlet UIProgressView *progressBar;
}

- (void)popWithTitle:(NSString *)title message:(NSString *)msg delegate:(id)delegate;
- (void)popWithTitle:(NSString *)title message:(NSString *)msg delegate:(id)delegate tag:(int)tag;
- (void)popAlertViewUserLooseQuestionWithDelegate:(id)delegate tag:(int)tag;

- (void)setDurationCounter:(int)duration;
- (void)setUsernameLabel:(NSString *)username;
- (void)setProgressBarToInit;

- (void)stopTimerCounter;

- (IBAction)acceptGage:(id)sender;
- (IBAction)refuseGage:(id)sender;

@end
