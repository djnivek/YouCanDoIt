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
#import "PackQR.h"

@implementation QRLibrary

- (id)init
{
    self = [super init];
    if (self) {
        dictionary = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (void)addQR:(QuestionReponse *)qr {
    NSString *idPack = [qr getStrignIdPack];
    
    if (!dictionary)
        dictionary = [[NSMutableDictionary alloc] init];
    
    PackQR *packQR = (PackQR *)[dictionary objectForKey:idPack];
    if (!packQR)
        packQR = [[PackQR alloc] initWithIdPack:[idPack intValue]];
    else
        [packQR addQR:qr];
}

- (int)nbOfQuestion {
    return [dictionary count];
}

- (BOOL)containsQuestions {
    return ([self nbOfQuestion] > 0);
}

- (QuestionReponse *)getQrWithIdPack:(int)idPack {
    PackQR *pQR = (PackQR *)[dictionary objectForKey:[NSString stringWithFormat:@"%d", idPack]];
    int r = arc4random() % [[pQR qrs] count];
    return [[pQR qrs] objectAtIndex:r];
}

- (void)saveToLocal {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"questions.txt"];
    [NSKeyedArchiver archiveRootObject:dictionary toFile:appFile];
}

- (void)loadFromLocal {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"questions.txt"];
    dictionary = [NSKeyedUnarchiver unarchiveObjectWithFile:appFile];
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
            QuestionReponse *q = [[QuestionReponse alloc] initWithQuestion:[question objectForKey:@"question"] answers:[question objectForKey:@"answers"] goodAnswer:[[[question objectForKey:@"answers"] objectForKey:@"right_answer"] intValue]];
            [q setIdPack:[[question objectForKey:@"id_pack_question"] intValue]];
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
