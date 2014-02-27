//
//  AppDelegate.h
//  jeuBoire
//
//  Created by Kévin MACHADO on 14/01/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameSession;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) GameSession *gameSession;

@property (retain, nonatomic) NSMutableArray *questionsListe;

@property (strong, nonatomic) NSMutableDictionary *gageListe;

@end
