//
//  ViewControllerGame.m
//  jeuBoire
//
//  Created by Kévin MACHADO on 14/01/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "ViewControllerGame.h"
#import "AppDelegate.h"
#import "QuestionReponse.h"
#import "Gage.h"
#import "QRFields.h"
#import "QRSController.h"
#import "GameSession.h"
#import "GageFields.h"

@interface ViewControllerGame ()

@end

@implementation ViewControllerGame

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    QRFields *qrFields = [[QRFields alloc] initWithFieldA:answerFieldA fieldB:answerFieldB fieldC:answerFieldC fieldD:answerFieldD];
    [qrFields setBtnA:btnAnswerA btnB:btnAnswerB btnC:btnAnswerC btnD:btnAnswerD];
    [qrFields setQuestionField:questionField];
    
    GageFields *ggFields = [[GageFields alloc] initWithGageField:gageField andAcceptBtn:acceptButton refuseBtn:refuseButton];
    
    game = [[GameSession alloc] initWithController:self QRFields:qrFields GGFields:ggFields];
    
    if ([game containQuestions] && [game containGages])
        [self startGame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)startGame {
    NSLog(@"ViewGameController || Start Game");
    [game newQuestion];
}

- (void)decSecond {
    if ([progressBar progress] == 0)
        [timerSecondCounter invalidate];
    [progressBar setProgress:[progressBar progress]-0.016666];
}

- (void)popWithTitle:(NSString *)title message:(NSString *)msg delegate:(id)delegate {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:delegate
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)popWithTitle:(NSString *)title message:(NSString *)msg delegate:(id)delegate tag:(int)tag {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:delegate
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert setTag:tag];
    [alert show];
}

- (void)popAlertViewUserLooseQuestionWithDelegate:(id)delegate tag:(int)tag {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                    message:@"You failed !"
                                                   delegate:delegate
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert setTag:tag];
    [alert show];
}

#pragma mark - TIMER -

- (void)setDurationCounter:(int)duration {
    [self stopTimerCounter];
    timerSecondCounter = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                          target:self
                                                        selector:@selector(decSecond)
                                                        userInfo:nil
                                                         repeats:YES];
}

- (void)stopTimerCounter {
    [timerSecondCounter invalidate];
}

#pragma mark - SETTER -

- (void)setProgressBarToInit {
    [progressBar setProgress:1.0];
}

- (void)setUsernameLabel:(NSString *)username {
    [userNameLabel setText:username];
}

#pragma mark - IBACTION -

- (IBAction)acceptGage:(id)sender {
    [game newQuestion];
}

- (IBAction)refuseGage:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Refus ??"
                                                    message:@"Vous devez boire la moitié de votre verre d'un seul coup !"
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil,
                          nil];
    [alert show];
}

@end