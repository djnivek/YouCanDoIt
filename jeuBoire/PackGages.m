//
//  PackGages.m
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 13/04/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "PackGages.h"
#import "Gage.h"

@implementation PackGages

- (id)init
{
    self = [super init];
    if (self) {
        idPackGage = 0;
        titre = @"Sans titre";
        description = @"Description du pack vide";
        gageList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithIdPack:(int)idPack
{
    self = [super init];
    if (self) {
        idPackGage = idPack;
        titre = @"Sans titre";
        description = @"Description du pack vide";
        gageList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addGage:(Gage *)g {
    [gageList addObject:g];
}

- (NSArray *)gagesWithLevel:(int)level {
    NSMutableArray *ggs = [[NSMutableArray alloc] init];
    for (Gage *g in gageList) {
        if ([g getLevel] == level)
            [ggs addObject:g];
    }
    return (NSArray *)ggs;
}

- (NSArray *)gages {
    return gageList;
}

@end
