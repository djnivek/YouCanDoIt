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
#import "ItemPackQuestion.h"

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

- (void)setPackQuestionAvalaible:(NSArray *)_packQuestion {
    packQuestionAvalaible = _packQuestion;
}

#pragma mark - Pull Question -

- (void)pullOtherQuestion {
    NSLog(@"QRSController || otherQuestion");
    int idPackRandom = [self findIdPackAmongAvailable];
    currentQuestionReponse = [self pullQuestionWithIdPack:idPackRandom];
    [qrFields setQuestionReponse:currentQuestionReponse];
}

- (int)findIdPackAmongAvailable {
    // Permet de trouver l'identifiant d'un pack aléatoire parmi les packs selectionnés
    int random = arc4random() % [packQuestionAvalaible count];
    ItemPackQuestion *pck = [packQuestionAvalaible objectAtIndex:random];
    return [[pck idPack] intValue];
}

- (QuestionReponse *)pullQuestionWithIdPack:(int)idPack {
    
    int r = arc4random() % [questionsResponses nbOfQuestion];
    currentQuestion = r;
    
    if ([questionsResponses containsQuestions]) {
        return [questionsResponses getQrWithIdPack:idPack];
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