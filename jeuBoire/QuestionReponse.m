//
//  Question.m
//  jeuBoire
//
//  Created by Kévin MACHADO on 19/01/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "QuestionReponse.h"

@implementation QuestionReponse

#pragma mark - INIT -

- (id)init
{
    self = [super init];
    if (self) {
        question = @"";
        answers = [[NSArray alloc] init];
        rightAnswer = 0;
    }
    return self;
}

- (id)initWithQuestion:(NSString *)_question answers:(NSDictionary*)_answersDict goodAnswer:(int)_rightAnswer {
    self = [super init];
    if (self) {
        question = _question;
        NSMutableArray *arrayAnwsers = [[NSMutableArray alloc] init];
        [arrayAnwsers addObject:_answersDict[@"answer_a"]];
        [arrayAnwsers addObject:_answersDict[@"answer_b"]];
        [arrayAnwsers addObject:_answersDict[@"answer_c"]];
        [arrayAnwsers addObject:_answersDict[@"answer_d"]];
        answers = arrayAnwsers;
        rightAnswer = _rightAnswer;
    }
    return self;
}

#pragma mark - GETTER -

- (NSString *)getQuestion {
    return question;
}

- (NSArray *)getAnswers {
    return answers;
}

- (int)getRightAnswer {
    return rightAnswer;
}

#pragma mark - SETTER -

- (void)setQuestion:(NSString *)_question {
    question = _question;
}

- (void)setAnswers:(NSArray *)_answers {
    answers = _answers;
}

- (void)setRightAnswer:(int)_right {
    rightAnswer = _right;
}

#pragma mark - SAVE/LOAD -

- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSLog(@"QuestionReponse || encodeWithCoder");
    [aCoder encodeObject:question forKey:@"question"];
    [aCoder encodeObject:answers forKey:@"answers"];
    [aCoder encodeInt:rightAnswer forKey:@"rightAnswer"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    NSLog(@"QuestionReponse || initWithCoder");
    if (self = [super init]) {
        question = [aDecoder decodeObjectForKey:@"question"];
        answers = [aDecoder decodeObjectForKey:@"answers"];
        rightAnswer = [aDecoder decodeIntForKey:@"rightAnswer"];
    }
    return self;
}

@end
