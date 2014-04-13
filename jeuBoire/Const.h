//
//  Const.h
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 24/03/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <Foundation/Foundation.h>

UIKIT_EXTERN NSString* const GAMESESSION_WrongResponse;
UIKIT_EXTERN NSString* const GAMESESSION_GoodResponse;
NSString* const SERVER;
NSString* const PORT;

@interface Const : NSObject

+ (NSString *)serverURL:(NSString *)theNamespace;

@end
