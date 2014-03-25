//
//  Player.m
//  jeuBoire
//
//  Created by Kévin MACHADO on 19/01/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "Player.h"

@implementation Player

- (id)init
{
    self = [super init];
    if (self) {
        idPlayer = 0;
        name = @"";
        sex = TRUE;
    }
    return self;
}

- (id)initWithName:(NSString *)thename idPlayer:(int)theid sex:(BOOL)thesex
{
    self = [super init];
    if (self) {
        idPlayer = theid;
        name = thename;
        sex = thesex;
    }
    return self;
}

#pragma mark - GETTERS -

- (NSString *)getName {
    return name;
}

- (int)getId {
    return idPlayer;
}

- (BOOL)isMan {
    return sex;
}

@end
