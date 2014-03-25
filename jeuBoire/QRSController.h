//
//  QuestionsController.h
//  jeuBoire
//
//  Created by Kévin MACHADO on 10/03/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QRFields;
@class QuestionReponse;
@class QRLibrary;

@interface QRSController : NSObject
{
    QRFields *qrFields;
    QRLibrary *questionsResponses;
    
    QuestionReponse *currentQuestionReponse;
    
    int currentQuestion;
}

- (id)initWithQRFields:(QRFields *)fields andQR:(QRLibrary *)qrs;
- (void)pullOtherQuestion;
- (BOOL)containQuestions;

- (void)didRespondByClickingOn:(id)sender;

@end