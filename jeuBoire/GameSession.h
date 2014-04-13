//
//  GameSession.h
//  jeuBoire
//
//  Created by Kévin MACHADO on 19/01/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QRSController;
@class ViewControllerGame;
@class AppDelegate;
@class QRFields;
@class GageFields;
@class GageController;

#define kAlertviewFailedResponse 1
#define kAlertviewSucceedResponse 2
#define kAlertviewRefuseGage 3

@interface GameSession : NSObject <UIAlertViewDelegate>
{
    NSMutableArray *players;
    
    int currentPlayer;
    
    //  CONTROLLER PRINCIPAL
    ViewControllerGame *mainController;
    
    //  QUESTION REPONSE
    QRSController *qrController;

    //  GAGE
    GageController *ggController;
    
    //  Application
    AppDelegate *application;
    
    int level;
    
    NSTimer *timerTimeToRespond;
}

- (id)initWithController:(ViewControllerGame *)_controller QRFields:(QRFields *)_qrFields GGFields:(GageFields *)_ggFields;
- (void)setPlayers:(NSArray *)_players;

- (BOOL)containQuestions;
- (BOOL)containGages;

- (void)newQuestion;

- (void)gageIt;
- (void)onGageAccepted;
- (void)onGageRefused;
- (void)onTimeOut;

@end
