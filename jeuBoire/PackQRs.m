//
//  PackQR.m
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 13/04/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "PackQRs.h"
#import "QuestionReponse.h"

@implementation PackQRs

- (id)init
{
    self = [super init];
    if (self) {
        idPackQR = 0;
        isFree = 0;
        titre = @"Sans titre";
        description = @"Description du pack vide";
        qrList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithIdPack:(int)idPack
{
    self = [super init];
    if (self) {
        idPackQR = idPack;
        isFree = 0;
        titre = @"Sans titre";
        description = @"Description du pack vide";
        qrList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addQR:(QuestionReponse *)qr {
    NSLog(@"PACK QRS ----> addQR %@", qr);
    [qrList addObject:qr];
}

#pragma mark - ACCESSORS -

- (NSArray *)qrs {
    return qrList;
}

- (NSString *)title {
    return titre;
}

- (NSString *)getID {
    return [[NSString alloc] initWithFormat:@"%d",idPackQR];
}

- (BOOL)isFree {
    return isFree;
}

- (void)setFree:(BOOL)free {
    isFree = free;
}

- (void)setTitle:(NSString *)title {
    titre = title;
}

#pragma mark - NSCoding -

- (void)encodeWithCoder:(NSCoder *)encoder {
    NSLog(@"PackQR || encodeWithCoder");
    [encoder encodeInt:idPackQR forKey:@"id_pack_qr"];
    [encoder encodeBool:isFree forKey:@"is_free"];
    [encoder encodeObject:titre forKey:@"title"];
    [encoder encodeObject:description forKey:@"description"];
    [encoder encodeObject:qrList forKey:@"qr_list"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSLog(@"PackQR || initWithCoder");
    if (self = [super init]) {
        idPackQR = [decoder decodeIntForKey:@"id_pack_qr"];
        isFree = [decoder decodeBoolForKey:@"is_free"];
        titre = [decoder decodeObjectForKey:@"title"];
        description = [decoder decodeObjectForKey:@"description"];
        qrList = [decoder decodeObjectForKey:@"qr_list"];
    }
    return self;
}

@end
