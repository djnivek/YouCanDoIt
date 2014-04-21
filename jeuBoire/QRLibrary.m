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
#import "PackQRs.h"

@implementation QRLibrary

- (id)init
{
    self = [super init];
    if (self) {
        dictionary = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (NSArray *)getPackContained {
    NSMutableArray *arrayPackContained = [[NSMutableArray alloc] init];
    for (NSString *key in [dictionary allKeys]) {
        PackQRs *pG = (PackQRs *)[dictionary objectForKey:key];
        [arrayPackContained addObject:pG];
    }
    return (NSArray *)arrayPackContained;
}

- (void)addQR:(QuestionReponse *)qr {
    NSString *idPack = [qr getStrignIdPack];
    
    if (!dictionary)
        dictionary = [[NSMutableDictionary alloc] init];
    
    PackQRs *packQR = (PackQRs *)[dictionary objectForKey:idPack];
    if (!packQR)
        packQR = [[PackQRs alloc] initWithIdPack:[idPack intValue]];
    [packQR addQR:qr];
    [dictionary setObject:packQR forKey:idPack];
}

/**
 *  Ajout du pack s'il n'existe pas
 **/
- (void)addPackQRs:(PackQRs *)pck {
    NSString *idPack = [pck getID];
    
    if (!dictionary)
        dictionary = [[NSMutableDictionary alloc] init];
    
    //PackQRs *packQR = (PackQRs *)[dictionary objectForKey:idPack];
    //if (!packQR)
        [dictionary setObject:pck forKey:idPack];
}

- (int)nbOfQuestion {
    return [dictionary count];
}

- (BOOL)containsQuestions {
    return ([self nbOfQuestion] > 0);
}

- (QuestionReponse *)getQrWithIdPack:(int)idPack {
    PackQRs *pQR = (PackQRs *)[dictionary objectForKey:[NSString stringWithFormat:@"%d", idPack]];
    int r = arc4random() % [[pQR qrs] count];
    return [[pQR qrs] objectAtIndex:r];
}

- (void)saveToLocal {
    NSLog(@"QR LIBRARY | Save to local");
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"questions.txt"];
    NSLog(@"QR LIBRARY | Save to local | dictionary -> %@", dictionary);
    [NSKeyedArchiver archiveRootObject:dictionary toFile:appFile];
}

- (void)loadFromLocal {
    NSLog(@"QR LIBRARY | Load from local");
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"questions.txt"];
    dictionary = [NSKeyedUnarchiver unarchiveObjectWithFile:appFile];
    NSLog(@"QR LIBRARY | Load from local | dictionary -> %@", dictionary);
}

- (void)loadFromWeb:(void (^)(void))completion onFailed:(void (^)(void))fail andForce:(BOOL)force {
    
    /// DELETE THIS LINE
#warning delete this line
    force=TRUE;
#warning delete this line
    /// DELETE THIS LINE
    
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [OpenUDID value], @"open_udid",
                            @"1", @"operating_system",
                            (force ? @"1" : @"0"), @"force_update",
                          nil];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[Const serverURL:@"questions.php"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Operation : %@ || Params : %@ || Response : %@", operation, params, responseObject);

        NSArray *lesPacksQuestions = [responseObject objectForKey:@"lespacks"];
        for (NSDictionary *packQuestions in lesPacksQuestions) {
            PackQRs *pck = [[PackQRs alloc] initWithIdPack:[[[packQuestions objectForKey:@"informations"] objectForKey:@"id_pack_question"] intValue]];
            [pck setFree:[[[packQuestions objectForKey:@"informations"] objectForKey:@"is_free"] boolValue]];
            [pck setTitle:[[packQuestions objectForKey:@"informations"] objectForKey:@"title"]];
            
            NSArray *lesQuestions = [packQuestions objectForKey:@"questions"];
            if ([pck isFree]) {
                for (NSDictionary *question in lesQuestions) {
                    QuestionReponse *q = [[QuestionReponse alloc] initWithQuestion:[question objectForKey:@"question"] answers:[question objectForKey:@"answers"] goodAnswer:[[[question objectForKey:@"answers"] objectForKey:@"right_answer"] intValue]];
                    [pck addQR:q];
                }
            }
            [self addPackQRs:pck];
        }
        [self saveToLocal];
        [completion invoke];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@ || operation : %@ || params : %@", error, operation, params);
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
