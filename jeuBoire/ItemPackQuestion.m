//
//  ItemQuestion.m
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 08/04/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "ItemPackQuestion.h"

@implementation ItemPackQuestion

- (id)init
{
    self = [super init];
    if (self) {
        title = @"";
        description = @"";
        idPack = 0;
        isFree = FALSE;
    }
    return self;
}

- (NSString *)title {
    return title;
}

- (NSString *)description {
    return description;
}

- (NSString *)idPack {
    return [NSString stringWithFormat:@"%d",idPack];
}

- (BOOL)isSecured {
    return !isFree;
}

- (void)setTitle:(NSString *)_title {
    title = _title;
}

- (void)setDescription:(NSString *)_description {
    description = _description;
}

- (void)setIdPack:(int)_idPack {
    idPack = _idPack;
}

- (void)setIsFree:(BOOL)free {
    isFree = free;
}

- (BOOL)isFree {
    return isFree;
}

@end
