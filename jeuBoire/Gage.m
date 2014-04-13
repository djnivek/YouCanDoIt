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
    idPack = 0;
    description = @"";
    containLevel = FALSE;
    duration = 0;
    return self;
}

- (id)initWithDesc:(NSString *)_desc idPack:(NSString *)_idPack containsLevels:(NSString *)_contains {
    description = _desc;
    containLevel = [_contains boolValue];
    idPack = [_idPack intValue];
    return self;
}

#pragma mark - Setters -

- (void)setLevel:(int)l {
    level = l;
}

- (void)setDuration:(int)d {
    duration = d;
}

- (void)setIdPack:(int)idpack {
    idPack = idpack;
}

- (void)setContainsLevel:(BOOL)contains {
    containLevel = contains;
}

- (void)setDescription:(NSString *)desc {
    description = desc;
}

#pragma mark - Getters -

- (int)getLevel {
    return level;
}

- (int)getDuration {
    return duration;
}

- (NSString *)getDescription {
    return description;
}

- (NSString *)getStrignIdPack {
    return [NSString stringWithFormat:@"%d", idPack];
}

- (BOOL)containsLevel {
    return containLevel;
}

#pragma mark - NSCoding -

- (void)encodeWithCoder:(NSCoder *)encoder {
    NSLog(@"Gage || encodeWithCoder");
    [encoder encodeBool:containLevel forKey:@"containLevel"];
    [encoder encodeInt:level forKey:@"level"];
    [encoder encodeInt:idPack forKey:@"idPack"];
    [encoder encodeObject:description forKey:@"description"];
    [encoder encodeInt:duration forKey:@"duration"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSLog(@"Gage || initWithCoder");
    if (self = [super init]) {
        containLevel = [decoder decodeBoolForKey:@"containLevel"];
        level = [decoder decodeIntForKey:@"level"];
        idPack = [decoder decodeIntForKey:@"idPack"];
        description = [decoder decodeObjectForKey:@"description"];
        duration = [decoder decodeIntForKey:@"duration"];
    }
    return self;
}

@end
