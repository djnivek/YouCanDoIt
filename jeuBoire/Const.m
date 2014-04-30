//
//  Const.m
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 24/03/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "Const.h"

NSString* const GAMESESSION_WrongResponse   = @"GAMESESSION_WrongResponse";
NSString* const GAMESESSION_GoodResponse    = @"GAMESESSION_GoodResponse";
//NSString* const SERVER                      = @"192.168.1.224";
NSString* const SERVER                      = @"10.0.1.161";
//NSString* const SERVER                      = @"localhost";
NSString* const PORT                        = @"8888";

@implementation Const

+ (NSString *)serverURL:(NSString *)theNamespace {
    return [NSString stringWithFormat:@"http://%@:%@/YouCanDoIt/%@", SERVER, PORT, theNamespace];
}

@end
