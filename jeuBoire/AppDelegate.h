//
//  AppDelegate.h
//  jeuBoire
//
//  Created by Kévin MACHADO on 14/01/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameSession;
@class Gages;
@class QRLibrary;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) GameSession *gameSession;

@property (retain, nonatomic) QRLibrary *questionsListe;

@property (strong, nonatomic) Gages *gagesList;

@end
