//
//  ViewControllerLoader.m
//  jeuBoire
//
//  Created by Kévin MACHADO on 20/01/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "ViewControllerLoader.h"
#import <AFNetworking.h>
#import <TSMessages/TSMessage.h>
#import "QuestionReponse.h"
#import "Gage.h"
#import "Gages.h"
#import "QRLibrary.h"
#import "AppDelegate.h"

@interface ViewControllerLoader ()

@end

@implementation ViewControllerLoader

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
    
    [TSMessage setDefaultViewController:self];
}

- (void)pushViewController {
    [self performSegueWithIdentifier:@"segueTransitionnal" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    
    app = [[UIApplication sharedApplication] delegate];
    
    [[app questionsListe] loadFromLocal];
    [[app gagesList] loadFromLocal];
    
    BOOL needForcedMAJ = (![[app questionsListe] containsQuestions] || ![[app gagesList] containsGages]);
    
    [self getQuestionsAndGagesComplete:^{
        [self pushViewController];
    }fail:^{
        if (needForcedMAJ)
            [TSMessage showNotificationWithTitle:@"Problème de connexion"
                                    subtitle:@"Un problème est survenu durant la tentative de récupération des questions du jeu, veuillez vérifier votre connexion"
                                        type:TSMessageNotificationTypeError];
        else
          [self pushViewController];
    } andForce:needForcedMAJ];
    
    
    //if ([[app questionsListe] containsQuestions] && [[app gagesList] containsGages])
      //  [self pushViewController];
}

- (void)getQuestionsAndGagesComplete:(void(^)(void))complete fail:(void(^)(void))fail andForce:(BOOL)force {
    [[app questionsListe] loadFromWeb:^{
        [self getGagesListeSucceed:^{
            [complete invoke];
        }fail:^{
            [fail invoke];
        } andForce:force];
    }onFailed:^{
        [fail invoke];
    } andForce:force];
}

- (void)getGagesListeSucceed:(void(^)(void))complete fail:(void(^)(void))fail andForce:(BOOL)force {
    [[app gagesList] loadFromWeb:^{
        [complete invoke];
    } onFailed:^{
        [TSMessage showNotificationWithTitle:@"Erreur"
                                    subtitle:@"Un problème est survenu durant la récupération des gages"
                                        type:TSMessageNotificationTypeError];
        [fail invoke];
    } andForce:force];
}

@end
