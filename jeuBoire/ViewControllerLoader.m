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
#import "Question.h"
#import "Gage.h"
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
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://localhost:8888/YouCanDoIt/questions.php" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        NSArray *questions = [responseObject objectForKey:@"Questions"];
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        for (NSDictionary* question in questions) {
            Question *q = [[Question alloc] initWithQuestion:[question objectForKey:@"question"] response:[question objectForKey:@"reponse"]];
            [[app questionsListe] addObject:q];
        }
        //[self performSegueWithIdentifier:@"segueTransitionnal" sender:self];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [TSMessage showNotificationWithTitle:@"Erreur"
                                    subtitle:@"Il y eu un problème durant la récupération des questions."
                                        type:TSMessageNotificationTypeError];
    }];
    
    AFHTTPRequestOperationManager *managergage = [AFHTTPRequestOperationManager manager];
    [managergage GET:@"http://localhost:8888/YouCanDoIt/gages.php" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        
        NSArray *gages = [responseObject objectForKey:@"Gages"];
        
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        
        NSMutableArray *g1 = [[NSMutableArray alloc] init];
        NSMutableArray *g2 = [[NSMutableArray alloc] init];
        NSMutableArray *g3 = [[NSMutableArray alloc] init];
        NSMutableArray *g4 = [[NSMutableArray alloc] init];
        NSMutableArray *g5 = [[NSMutableArray alloc] init];
        
        for (NSDictionary* gage in gages) {
            if  ([[gage objectForKey:@"level"] isEqualToString:@"1"]) {
                Gage *g = [[Gage alloc] initWithLevel:1 desc:[gage objectForKey:@"description"]];
                [g1 addObject:g];
            }
            if  ([[gage objectForKey:@"level"] isEqualToString:@"2"]) {
                Gage *g = [[Gage alloc] initWithLevel:2 desc:[gage objectForKey:@"description"]];
                [g2 addObject:g];
            }
            if  ([[gage objectForKey:@"level"] isEqualToString:@"3"]) {
                Gage *g = [[Gage alloc] initWithLevel:3 desc:[gage objectForKey:@"description"]];
                [g3 addObject:g];
            }
            if  ([[gage objectForKey:@"level"] isEqualToString:@"4"]) {
                Gage *g = [[Gage alloc] initWithLevel:4 desc:[gage objectForKey:@"description"]];
                [g4 addObject:g];
            }
            if  ([[gage objectForKey:@"level"] isEqualToString:@"5"]) {
                Gage *g = [[Gage alloc] initWithLevel:5 desc:[gage objectForKey:@"description"]];
                [g5 addObject:g];
            }
        }
        
        [[app gageListe] addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:g1,@"1", nil]];
        [[app gageListe] addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:g2,@"2", nil]];
        [[app gageListe] addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:g3,@"3", nil]];
        [[app gageListe] addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:g4,@"4", nil]];
        [[app gageListe] addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:g5,@"5", nil]];
        
        //[self performSegueWithIdentifier:@"segueTransitionnal" sender:self];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [TSMessage showNotificationWithTitle:@"Erreur"
                                    subtitle:@"Il y eu un problème durant la récupération des gages."
                                        type:TSMessageNotificationTypeError];
    }];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)test:(id)sender {
    [self performSegueWithIdentifier:@"segueTransitionnal" sender:self];
}
@end
