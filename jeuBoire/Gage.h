//
//  Gage.h
//  jeuBoire
//
//  Created by Kévin MACHADO on 19/01/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gage : NSObject <NSCoding>
{
    BOOL containLevel;
    int level;
    int idPack;
    int duration;
    NSString *description;
}

- (id)initWithDesc:(NSString *)_desc idPack:(NSString *)_idPack containsLevels:(NSString *)_contains;

- (void)setLevel:(int)l;
- (void)setDuration:(int)d;
- (void)setIdPack:(int)idpack;
- (void)setContainsLevel:(BOOL)contains;
- (void)setDescription:(NSString *)desc;

- (NSString *)getDescription;
- (NSString *)getStrignIdPack;
- (int)getLevel;
- (int)getDuration;
- (BOOL)containsLevel;

@end