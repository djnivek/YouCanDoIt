//
//  QuestionsController.m
//  jeuBoire
//
//  Created by Kévin MACHADO on 10/03/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "QRSController.h"
#import "QRFields.h"
#import "QuestionReponse.h"
#import "QRLibrary.h"

@implementation QRSController

- (id)initWithQRFields:(QRFields *)fields andQR:(QRLibrary *)qrs {
    self = [super init];
    if (self) {
        qrFields = fields;
        [qrFields setController:self];
        
        questionsResponses = qrs;
    }
    return self;
}

#pragma mark - Pull Question -

- (void)pullOtherQuestion {
    NSLog(@"QRSController || otherQuestion");
    currentQuestionReponse = [self pullQuestion];
    [qrFields setQuestionReponse:currentQuestionReponse];
}

- (QuestionReponse *)pullQuestion {
    
    int r = arc4random() % [questionsResponses nbOfQuestion];
    currentQuestion = r;
    
    if ([questionsResponses containsQuestions]) {
        return [questionsResponses getQrAtIndex:r];
    }
    
    return [[QuestionReponse alloc] initWithQuestion:@"Unknow" answers:NULL goodAnswer:0];
}

#pragma mark - Statement -

- (BOOL)containQuestions {
    return [questionsResponses containsQuestions];
}

#pragma mark - onClick -> Response -

- (void)didRespondByClickingOn:(id)sender {
    if ([sender tag] == [currentQuestionReponse getRightAnswer]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:GAMESESSION_GoodResponse object:nil userInfo:nil];
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:GAMESESSION_WrongResponse object:nil userInfo:nil];
    }
}

@end