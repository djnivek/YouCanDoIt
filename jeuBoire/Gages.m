//
//  Gages.m
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 19/03/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "Gages.h"
#import "Gage.h"
#import "ViewControllerLoader.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "OpenUDID.h"
#import "PackGages.h"

@implementation Gages

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"Gages || init");
        dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (NSArray *)getForIdPack:(int)idPack level:(int)level {
    NSString *strIdPack = [NSString stringWithFormat:@"%d",idPack];
    //NSMutableArray *gages = [[NSMutableArray alloc] init];
    PackGages *pckGages = [dictionary objectForKey:strIdPack];
    return [pckGages gagesWithLevel:level];
}

- (NSArray *)getForIdPack:(int)idPack {
    PackGages *pG = (PackGages *)[dictionary objectForKey:[NSString stringWithFormat:@"%d", idPack]];
    return [pG gages];
}

- (NSArray *)getIdPackContained {
    return [dictionary allKeys];
}

- (NSArray *)getPackContained {
    NSMutableArray *arrayPackContained = [[NSMutableArray alloc] init];
    for (NSString *key in [dictionary allKeys]) {
        PackGages *pG = (PackGages *)[dictionary objectForKey:key];
        [arrayPackContained addObject:pG];
    }
    return (NSArray *)arrayPackContained;
}

- (void)addGage:(Gage *)gage {
    NSString *idPack = [gage getStrignIdPack];
    
    if (!dictionary)
        dictionary = [[NSMutableDictionary alloc] init];
    
    PackGages *packG = (PackGages *)[dictionary objectForKey:idPack];
    if (!packG)
        packG = [[PackGages alloc] initWithIdPack:[idPack intValue]];
    [packG addGage:gage];
    [dictionary setObject:packG forKey:idPack];
}

- (BOOL)containsGages {
    return ([dictionary count] > 0);
}

#pragma mark - SAVE/LOAD -

- (void)saveToLocal {
    NSLog(@"GAGES | Save to local");
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"gages.txt"];
    NSLog(@"GAGES | Save to local | dictionary -> %@", dictionary);
    [NSKeyedArchiver archiveRootObject:dictionary toFile:appFile];
}

- (void)loadFromLocal {
    NSLog(@"GAGES | Load from local");
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"gages.txt"];
    dictionary = [NSKeyedUnarchiver unarchiveObjectWithFile:appFile];
    NSLog(@"GAGES | Load from local | dictionary -> %@", dictionary);
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
    [manager POST:[Const serverURL:@"gages.php"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Operation : %@ || Params : %@ || Response : %@", operation, params, responseObject);
        
        NSArray *gages = [responseObject objectForKey:@"Gages"];
        for (NSDictionary *g in gages) {
            if ([[[g objectForKey:@"pack_gage"] objectForKey:@"is_free"] boolValue]) {
                Gage *gage = [[Gage alloc] init];
                [gage setLevel:[[[g objectForKey:@"gage"] objectForKey:@"level"] intValue]];
                [gage setDescription:[[g objectForKey:@"gage"] objectForKey:@"label"]];
                [gage setIdPack:[[[g objectForKey:@"pack_gage"] objectForKey:@"id_pack_gage"] intValue]];
                [gage setContainsLevel:[[[g objectForKey:@"gage"] objectForKey:@"contains_levels"] boolValue]];
                [gage setDuration:[[[g objectForKey:@"gage"] objectForKey:@"duration"] intValue]];
                [self addGage:gage];
            } else {
                
            }
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
                            @"askfor", @"is_update_required",
                            [OpenUDID value], @"open_udid",
                            @"1", @"operating_system",
                            nil];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[Const serverURL:@"gages.php"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        required([responseObject boolForKey:@"id_pack_gage"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        required(NO);
    }];
}*/

@end
