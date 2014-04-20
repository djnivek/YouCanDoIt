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

- (NSString *)title {
    return titre;
}

#pragma mark - NSCoding -

- (void)encodeWithCoder:(NSCoder *)encoder {
    NSLog(@"PackGages || encodeWithCoder");
    [encoder encodeInt:idPackGage forKey:@"id_pack_gage"];
    [encoder encodeObject:titre forKey:@"title"];
    [encoder encodeObject:description forKey:@"description"];
    [encoder encodeObject:gageList forKey:@"gage_list"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSLog(@"PackGages || initWithCoder");
    if (self = [super init]) {
        idPackGage = [decoder decodeIntForKey:@"id_pack_gage"];
        titre = [decoder decodeObjectForKey:@"title"];
        description = [decoder decodeObjectForKey:@"description"];
        gageList = [decoder decodeObjectForKey:@"gage_list"];
    }
    return self;
}

@end
