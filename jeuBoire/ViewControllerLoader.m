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
    
	// Do any additional setup after loading the view.
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
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    [[app questionsListe] loadFromLocal];
    if (![[app questionsListe] containsQuestions]) {
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:@"http://localhost:8888/YouCanDoIt/questions.php" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSArray *questions = [responseObject objectForKey:@"Questions"];
            
            for (NSDictionary* question in questions) {
                QuestionReponse *q = [[QuestionReponse alloc] initWithQuestion:[question objectForKey:@"question"] answers:[question objectForKey:@"answers"] goodAnswer:[[[question objectForKey:@"answers"] objectForKey:@"rightAnswer"] intValue]];
                [[app questionsListe] addQR:q];
            }
            [[app questionsListe] saveToLocal];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [TSMessage showNotificationWithTitle:@"Erreur"
                                        subtitle:@"Un problème est survenu durant la récupération des questions"
                                            type:TSMessageNotificationTypeError];
        }];
    }
    
    [[app gagesList] loadFromLocal];
    if (![[app gagesList] containsGages]) {
        
        AFHTTPRequestOperationManager *managergage = [AFHTTPRequestOperationManager manager];
        [managergage GET:@"http://localhost:8888/YouCanDoIt/gages.php" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dictIdPackGage = [responseObject objectForKey:@"id_pack_gage"];
            for (NSString *idPackGage in dictIdPackGage) {
                NSDictionary *dictGages = [dictIdPackGage objectForKey:idPackGage];
                
                for (NSDictionary *g in dictGages) {
                    Gage *gage = [[Gage alloc] init];
                    [gage setLevel:[[g objectForKey:@"level"] intValue]];
                    [gage setDescription:[g objectForKey:@"label"]];
                    [gage setIdPack:[[g objectForKey:@"id_pack_gage"] intValue]];
                    [gage setContainsLevel:[[g objectForKey:@"contains_levels"] boolValue]];
                    
                    [[app gagesList] addGage:gage];
                }
            }
            
            [[app gagesList] saveToLocal];
            
            [self pushViewController];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [TSMessage showNotificationWithTitle:@"Erreur"
                                        subtitle:@"Un problème est survenu durant la récupération des gages"
                                            type:TSMessageNotificationTypeError];
        }];
    }
    
    if ([[app questionsListe] containsQuestions] && [[app gagesList] containsGages])
        [self pushViewController];
}

@end
