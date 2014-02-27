//
//  Gage.m
//  jeuBoire
//
//  Created by Kévin MACHADO on 19/01/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "Gage.h"

@implementation Gage

- (id)init {
    level = 0;
    description = @"";
    return self;
}

- (id)initWithLevel:(int)_level desc:(NSString *)d {
    level = _level;
    description = d;
    return self;
}

- (NSString *)getDescription {
    return description;
}

@end
