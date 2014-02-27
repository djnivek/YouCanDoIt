//
//  Question.m
//  jeuBoire
//
//  Created by Kévin MACHADO on 19/01/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "Question.h"

@implementation Question

- (id)init {
    question = @"";
    reponse = @"";
    return self;
}

- (id)initWithQuestion:(NSString *)q response:(NSString *)r {
    question = q;
    reponse = r;
    return self;
}

- (NSString *)getQuestion {
    return question;
}

-(NSString *)getResponse {
    return reponse;
}

@end
