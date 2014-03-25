//
//  Gages.m
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 19/03/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "Gages.h"
#import "Gage.h"

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
    NSLog(@"----> %@", [gage getDescription]);
    NSString *idPack = [gage getStrignIdPack];
    
    if (!dictionary)
        dictionary = [[NSMutableDictionary alloc] init];
    
    NSMutableArray *gages = (NSMutableArray *)[dictionary objectForKey:idPack];
    if (!gages)
        gages = [[NSMutableArray alloc] initWithObjects:gage, nil];
    else
        [gages addObject:gage];
    [dictionary setObject:gages forKey:idPack];
    NSLog(@"add Gage || dict : %@", dictionary);
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
    NSLog(@"saveToLocal %@ : dict : %@", appFile, dictionary);
    BOOL test = [NSKeyedArchiver archiveRootObject:dictionary toFile:appFile];
    NSLog(@"Voila -> %d", test);
}

- (void)loadFromLocal {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"gages.txt"];
    dictionary = [NSKeyedUnarchiver unarchiveObjectWithFile:appFile];
    NSLog(@"loadFromLocal : %@", dictionary);
}

@end
