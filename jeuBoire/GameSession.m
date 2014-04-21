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

#define SEC_DURATION_RESPONSE 6

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
        packAvailableQuestion = [[NSArray alloc] init];
        packAvailableGage = [[NSArray alloc] init];
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

- (void)setPackAvalaible:(NSDictionary *)_packAvalaible {
    packAvailableQuestion   = (NSArray *)   [_packAvalaible objectForKey:@"pack_questions"];
    packAvailableGage       = (NSArray *)   [_packAvalaible objectForKey:@"pack_gages"];
    [ggController setPackGageAvalaible:packAvailableGage];
    [qrController setPackQuestionAvalaible:packAvailableQuestion];
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
    [self setDurationToRespond:SEC_DURATION_RESPONSE];
}

- (void)setDurationToRespond:(int)duration {
    [timerTimeToRespond invalidate];
    timerTimeToRespond = [NSTimer scheduledTimerWithTimeInterval:duration
                                     target:self
                                   selector:@selector(onTimeOut)
                                   userInfo:nil
                                    repeats:NO];
    [mainController setDurationCounter:duration];
}

- (BOOL)containQuestions {
    return [qrController containQuestions];
}

#pragma mark - GAGES -

- (BOOL)containGages {
    return [ggController containGages];
}

- (void)gageIt {
    [ggController otherGageWithLevel:level];
}

- (void)onGageRefused {
    [mainController popWithTitle:@"You refuse ?" message:@"Let's giving you an other one ;)" delegate:self tag:kAlertviewRefuseGage];
}

- (void)onGageAccepted {
    [mainController popDurationAlertWith:[ggController currentGageDuration]];
}

#pragma mark - TIMER -

- (void)stopAllTimers {
    [timerTimeToRespond invalidate];
    [mainController stopTimerCounter];
}

- (void)onTimeOut {
    NSLog(@"GameSession || onTimeOut");
    [timerTimeToRespond invalidate];
    [mainController stopTimerCounter];
    [mainController popWithTitle:@"Time Out" message:@"I hope next time you will respond !" delegate:self tag:kAlertviewFailedResponse];
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
    [self onPopUpClickWithTag:[alertView tag] andIndexButton:buttonIndex];
}

- (void)onPopUpClickWithTag:(NSInteger)tag andIndexButton:(NSInteger)index {
    if (tag == kAlertviewFailedResponse) {
        if (index == 0) {
            [self gageIt];
        }
    }
    else if (tag == kAlertviewSucceedResponse) {
        [self newQuestion];
    }
    else if (tag == kAlertviewRefuseGage) {
        [self gageIt];
    }
}

@end
