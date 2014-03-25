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
    NSMutableArray *questionsListe;
}

- (void)addQR:(QuestionReponse *)qr;

- (int)nbOfQuestion;
- (BOOL)containsQuestions;

- (QuestionReponse *)getQrAtIndex:(int)i;

- (void)saveToLocal;
- (void)loadFromLocal;

@end
