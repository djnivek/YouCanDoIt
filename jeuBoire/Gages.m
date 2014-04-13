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
    NSMutableArray *gages = [[NSMutableArray alloc] init];
    for (Gage *g in [dictionary objectForKey:strIdPack]) {
        NSLog(@"Gages || %@", [g getDescription]);
        NSLog(@"Gages || %d", [g getDuration]);
        if ([g getLevel] == level)
            [gages addObject:g];
    }
    return (NSArray *)gages;
}

- (NSArray *)getForIdPack:(int)idPack {
    return [dictionary objectForKey:[NSString stringWithFormat:@"%d", idPack]];
}

- (NSArray *)getIdPackContained {
    return [dictionary allKeys];
}

- (void)addGage:(Gage *)gage {
    NSString *idPack = [gage getStrignIdPack];
    
    if (!dictionary)
        dictionary = [[NSMutableDictionary alloc] init];
    
    NSMutableArray *gages = (NSMutableArray *)[dictionary objectForKey:idPack];
    if (!gages)
        gages = [[NSMutableArray alloc] initWithObjects:gage, nil];
    else
        [gages addObject:gage];
    
    [dictionary setObject:gages forKey:idPack];
}

- (NSMutableDictionary *)dict {
    return dictionary;
}

- (BOOL)containsGages {
    return ([dictionary count] > 0);
}

#pragma mark - SAVE/LOAD -

- (void)saveToLocal {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"gages.txt"];
    [NSKeyedArchiver archiveRootObject:dictionary toFile:appFile];
}

- (void)loadFromLocal {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"gages.txt"];
    dictionary = [NSKeyedUnarchiver unarchiveObjectWithFile:appFile];
}

- (void)loadFromWeb:(void (^)(void))completion onFailed:(void (^)(void))fail andForce:(BOOL)force {
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [OpenUDID value], @"open_udid",
                            @"1", @"operating_system",
                            (force ? @"1" : @"0"), @"force_update",
                            nil];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[Const serverURL:@"gages.php"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Operation : %@ || Params : %@ || Response : %@", operation, params, responseObject);
        
        NSDictionary *dictIdPackGage = [responseObject objectForKey:@"id_pack_gage"];
        for (NSString *idPackGage in dictIdPackGage) {
            NSDictionary *dictGages = [dictIdPackGage objectForKey:idPackGage];
            
            for (NSDictionary *g in dictGages) {
                Gage *gage = [[Gage alloc] init];
                [gage setLevel:[[g objectForKey:@"level"] intValue]];
                [gage setDescription:[g objectForKey:@"label"]];
                [gage setIdPack:[[g objectForKey:@"id_pack_gage"] intValue]];
                [gage setContainsLevel:[[g objectForKey:@"contains_levels"] boolValue]];
                [gage setDuration:[[g objectForKey:@"duration"] intValue]];
                
                [self addGage:gage];
            }
        }
        
        [self saveToLocal];
        [completion invoke];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
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
