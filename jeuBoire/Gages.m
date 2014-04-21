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

- (void)addPackGage:(PackGages *)pack {
    NSString *idPack = [pack getID];
    
    if (!dictionary)
        dictionary = [[NSMutableDictionary alloc] init];
    
    //PackGages *packG = (PackGages *)[dictionary objectForKey:idPack];
    //if (!packG)
        [dictionary setObject:pack forKey:idPack];
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
        
        NSArray *lesPacksGages = [responseObject objectForKey:@"lespacks"];
        for (NSDictionary *packGages in lesPacksGages) {
            PackGages *pack = [[PackGages alloc] init];
            [pack setIsFree:[[[packGages objectForKey:@"informations"] objectForKey:@"is_free"] boolValue]];
            [pack setTitre:[[packGages objectForKey:@"informations"] objectForKey:@"title"]];
            [pack setIdPack:[[[packGages objectForKey:@"informations"] objectForKey:@"id_pack_gage"] intValue]];
            
            NSArray *lesGages = [packGages objectForKey:@"gages"];
            if ([pack isFree]) {
                for (NSDictionary *leGage in lesGages) {
                    Gage *gage = [[Gage alloc] init];
                    [gage setLevel:[[leGage objectForKey:@"level"] intValue]];
                    [gage setDescription:[leGage objectForKey:@"label"]];
                    [gage setIdPack:[[leGage objectForKey:@"id_pack_gage"] intValue]];
                    [gage setContainsLevel:[[leGage objectForKey:@"contains_levels"] boolValue]];
                    [gage setDuration:[[leGage objectForKey:@"duration"] intValue]];
                    [pack addGage:gage];
                }
            }
            [self addPackGage:pack];
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
