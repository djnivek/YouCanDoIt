//
//  QRLibrary.h
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 23/03/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QuestionReponse;

@interface QRLibrary : NSObject
{
    NSMutableDictionary *dictionary;
}

- (void)addQR:(QuestionReponse *)qr;

- (int)nbOfQuestion;
- (BOOL)containsQuestions;

- (QuestionReponse *)getQrWithIdPack:(int)idPack;

- (void)saveToLocal;
- (void)loadFromLocal;
- (void)loadFromWeb:(void (^)(void))completion onFailed:(void (^)(void))fail andForce:(BOOL)force;

@end
