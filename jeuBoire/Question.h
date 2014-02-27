//
//  Question.h
//  jeuBoire
//
//  Created by Kévin MACHADO on 19/01/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject
{
    NSString *question;
    NSString *reponse;
}

- (id)initWithQuestion:(NSString *)q response:(NSString *)r;

-(NSString *)getQuestion;
-(NSString *)getResponse;

@end
