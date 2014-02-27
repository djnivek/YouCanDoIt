//
//  ViewControllerGame.m
//  jeuBoire
//
//  Created by Kévin MACHADO on 14/01/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "ViewControllerGame.h"
#import "AppDelegate.h"
#import "Question.h"
#import "Gage.h"

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
    
    players = [[NSMutableArray alloc] initWithObjects:@"Joueur1", @"Joueur2", nil];
    currentPlayer = 0;
    currentQuestion = 0;
    
    countQ = 0;
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    questions = [app questionsListe];
    gages = [app gageListe];
    
    [self startGame];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startGame {
    [self newRound];
}

- (void)findPlayer {
    currentPlayer ++;
    
    if (currentPlayer == [players count])
        currentPlayer = 0;
}

- (void)newRound {
    [self displayGageLayout:FALSE];
    [self findPlayer];
    [userNameLabel setText:[players objectAtIndex:currentPlayer]];
    [self newQuestion];
}

- (void)newQuestion {
    
    int r = arc4random() % [questions count];
    currentQuestion = r;
    Question *q = [questions objectAtIndex:currentQuestion];
    second = 5;
    
    [answerField setText:@""];
    countQ++;
    [questionsField setText:[q getQuestion]];
    [NSTimer scheduledTimerWithTimeInterval:5.0
                                     target:self
                                   selector:@selector(theAnswer)
                                   userInfo:nil
                                    repeats:NO];
    
    timerSecondCounter = [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(decSecond)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)decSecond {
    second--;
    if (second <= 0)
        [timerSecondCounter invalidate];
    [secondCount setText:[NSString stringWithFormat:@"%i", second]];
}

- (void)theAnswer {
    Question *q = [questions objectAtIndex:currentQuestion];
    [answerField setText:[q getResponse]];
    
    currentQuestion++;
    
    if (currentQuestion == [questions count])
        currentPlayer = 0;
    
    [NSTimer scheduledTimerWithTimeInterval:3
                                     target:self
                                   selector:@selector(pop)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)pop {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Temps écoulé"
                                                    message:@"Avez-vous bien répondu à la question ?"
                                                   delegate:self
                                          cancelButtonTitle:@"Oui"
                                          otherButtonTitles:@"Non",
                          nil];
    [alert show];
}

- (void)gage {
    
    [self displayGageLayout:TRUE];
    
    NSArray *array;
    
    if (countQ > 45) {
        array = [gages objectForKey:@"4"];
    } else if (countQ > 30) {
        array = [gages objectForKey:@"3"];
    } else if (countQ > 15) {
        array = [gages objectForKey:@"2"];
    } else {
        array = [gages objectForKey:@"1"];
    }
    
    int r = arc4random() % [array count];
    
    //Sauf si l'utilisateur à payé le pack + qui permet de brider quelques gages pour lui même.
    //L'utilisateur choisi le nom qui sera toujours bridé et SI currentplayer.name = packplus.namebride ALORS SI gage = gagebridés ALORS
    //nouveau tirage
    [gageField setText:[(Gage *)[array objectAtIndex:r] getDescription]];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self newRound];
    }
    else {
        [self gage];
    }
}

- (void)displayGageLayout:(BOOL)displayIt {
    [acceptButton setHidden:!displayIt];
    [refuseButton setHidden:!displayIt];
    [gageField setHidden:!displayIt];
}

- (IBAction)acceptGage:(id)sender {
    [self newRound];
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
