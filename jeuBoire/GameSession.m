//
//  GameSession.m
//  jeuBoire
//
//  Created by Kévin MACHADO on 19/01/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "GameSession.h"
#import "ViewControllerGame.h"
#import "QRSController.h"
#import "AppDelegate.h"
#import "GageFields.h"
#import "Gages.h"
#import "GageController.h"
#import "Player.h"

@implementation GameSession

- (id)initWithController:(ViewControllerGame *)_controller QRFields:(QRFields *)_qrFields GGFields:(GageFields *)_ggFields
{
    self = [super init];
    if (self) {
        
        [self addListener];
        
        mainController = _controller;
        application = [[UIApplication sharedApplication] delegate];
        qrController = [[QRSController alloc] initWithQRFields:_qrFields andQR:[application questionsListe]];
        ggController = [[GageController alloc] initWithGageFields:_ggFields andGages:[application gagesList]];
        Player *kevin = [[Player alloc] initWithName:@"Kevin" idPlayer:1 sex:TRUE];
        Player *violette = [[Player alloc] initWithName:@"Violette" idPlayer:2 sex:FALSE];
        players = [[NSMutableArray alloc] initWithObjects:kevin, violette, nil];
        level = 0;
    }
    return self;
}

- (void)addListener {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGoodResponse)
                                                 name:GAMESESSION_GoodResponse object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onWrongResponse)
                                                 name:GAMESESSION_WrongResponse object:nil];
}

- (void)setPlayers:(NSArray *)_players {
    players = [NSMutableArray arrayWithArray:_players];
}

- (void)findPlayer {
    NSLog(@"GameSession || Find Player");
    currentPlayer ++;
    if (currentPlayer == [players count]) {
        //  Nous venons de faire un tour complet
        currentPlayer = 0;
    }
    [mainController setUsernameLabel:[[players objectAtIndex:currentPlayer] getName]];
}

- (void)newQuestion {
    NSLog(@"GameSession || new Question");
    [mainController setProgressBarToInit];
    [ggController hiddeGageLayout:TRUE];
    [self findPlayer];
    [qrController pullOtherQuestion];
    [self setDurationToRespond:6];
}

- (void)setDurationToRespond:(int)duration {
    [timerTimeToRespond invalidate];
    timerTimeToRespond = [NSTimer scheduledTimerWithTimeInterval:duration
                                     target:self
                                   selector:@selector(newQuestion)
                                   userInfo:nil
                                    repeats:NO];
    [mainController setDurationCounter:duration];
}

- (BOOL)containQuestions {
    return [qrController containQuestions];
}

- (BOOL)containGages {
    return [ggController containGages];
}

- (void)gageIt {
    [ggController otherGageWithLevel:level];
}

#pragma mark - TIMER -

- (void)stopAllTimers {
    [timerTimeToRespond invalidate];
    [mainController stopTimerCounter];
}

#pragma mark - RESPONSE -

- (void)onGoodResponse {
    NSLog(@"onGoodResponse");
    [self goodResponseAction];
}

- (void)goodResponseAction {
    [self stopAllTimers];
    [mainController setProgressBarToInit];
    [mainController popWithTitle:@"Congratulation" message:@"This is the good answer !\n Next player !" delegate:self tag:kAlertviewSucceedResponse];
}

- (void)onWrongResponse {
    NSLog(@"onWrongResponse");
    [self wrongResponseAction];
}

- (void)wrongResponseAction {
    [self stopAllTimers];
    [mainController setProgressBarToInit];
    [mainController popAlertViewUserLooseQuestionWithDelegate:self tag:kAlertviewFailedResponse];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([alertView tag] == kAlertviewFailedResponse) {
        if (buttonIndex == 0) {
            [self gageIt];
        }
    }
    else if ([alertView tag] == kAlertviewSucceedResponse) {
        [self newQuestion];
    }
}

@end
