//
//  Question.h
//  jeuBoire
//
//  Created by Kévin MACHADO on 19/01/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionReponse : NSObject <NSCoding>
{
    NSString *question;
    NSArray *answers;
    int idPack;
    int rightAnswer;
}

/**     INIT    **/
- (id)initWithQuestion:(NSString *)_question answers:(NSDictionary*)_answersDict goodAnswer:(int)_rightAnswer;

/**     GET     **/
- (NSString *)getQuestion;
- (NSString *)getStrignIdPack;
- (NSArray *)getAnswers;
- (int)getRightAnswer;

/**     SET     **/
- (void)setQuestion:(NSString *)_question;
- (void)setIdPack:(int)idpack;
- (void)setAnswers:(NSArray *)_answers;
- (void)setRightAnswer:(int)_right;

@end
