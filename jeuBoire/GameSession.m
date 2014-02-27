//
//  GameSession.m
//  jeuBoire
//
//  Created by Kévin MACHADO on 19/01/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "GameSession.h"

@implementation GameSession

- (id)init {
    players = [[NSMutableArray alloc] init];
    round = 0;
    return self;
}

@end
