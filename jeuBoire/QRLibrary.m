//
//  QRLibrary.m
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 23/03/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "QRLibrary.h"
#import "QuestionReponse.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "OpenUDID.h"

@implementation QRLibrary

- (id)init
{
    self = [super init];
    if (self) {
        questionsListe = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)addQR:(QuestionReponse *)qr {
    if (!questionsListe)
        questionsListe = [[NSMutableArray alloc]init];
    
    [questionsListe addObject:qr];
}

- (int)nbOfQuestion {
    return [questionsListe count];
}

- (BOOL)containsQuestions {
    return ([questionsListe count] > 0);
}

- (QuestionReponse *)getQrAtIndex:(int)i {
    return [questionsListe objectAtIndex:i];
}

- (void)saveToLocal {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"questions.txt"];
    [NSKeyedArchiver archiveRootObject:questionsListe toFile:appFile];
}

- (void)loadFromLocal {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"questions.txt"];
    questionsListe = [NSKeyedUnarchiver unarchiveObjectWithFile:appFile];
}

- (void)loadFromWeb:(void (^)(void))completion onFailed:(void (^)(void))fail andForce:(BOOL)force {
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [OpenUDID value], @"open_udid",
                            @"1", @"operating_system",
                            (force ? @"1" : @"0"), @"force_update",
                          nil];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[Const serverURL:@"questions.php"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Operation : %@ || Params : %@ || Response : %@", operation, params, responseObject);

        NSArray *questions = [responseObject objectForKey:@"Questions"];
        for (NSDictionary* question in questions) {
            QuestionReponse *q = [[QuestionReponse alloc] initWithQuestion:[question objectForKey:@"question"] answers:[question objectForKey:@"answers"] goodAnswer:[[[question objectForKey:@"answers"] objectForKey:@"rightAnswer"] intValue]];
            [self addQR:q];
        }
        [self saveToLocal];
        [completion invoke];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@ || params : %@", error, params);
        [fail invoke];
    }];
}

/*- (void)isUpdateRequired:(void(^)(BOOL))required {
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            @"is_update_required", @"askfor",
                            [OpenUDID value], @"open_udid",
                            nil];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[Const serverURL:@"questions.php"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        required([responseObject boolForKey:@"id_pack_gage"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        required(NO);
    }];
}*/

@end
