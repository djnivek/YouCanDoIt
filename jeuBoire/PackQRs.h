//
//  PackQR.h
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 13/04/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QuestionReponse;

@interface PackQRs : NSObject
{
    int idPackQR;
    int isFree;
    NSString *titre;
    NSString *description;
    NSMutableArray *qrList;
}

- (id)initWithIdPack:(int)idPack;

- (void)addQR:(QuestionReponse *)qr;
- (NSArray *)qrs;
- (NSString *)title;
- (NSString *)getID;

- (void)setFree:(BOOL)free;
- (void)setTitle:(NSString *)title;

@end
