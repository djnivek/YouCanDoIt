//
//  PackQR.m
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 13/04/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "PackQR.h"
#import "QuestionReponse.h"

@implementation PackQR

- (id)init
{
    self = [super init];
    if (self) {
        idPackQR = 0;
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
        titre = @"Sans titre";
        description = @"Description du pack vide";
        qrList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addQR:(QuestionReponse *)qr {
    [qrList addObject:qr];
}

- (NSArray *)qrs {
    return qrList;
}

@end
