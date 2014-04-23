//
//  ItemQuestion.h
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 08/04/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemPackGages : NSObject
{
    NSString *title;
    NSString *description;
    int idPack;
    BOOL isFree;
    //NSString *image;
}

- (NSString *)title;
- (NSString *)description;
- (NSString *)idPack;
- (BOOL)isSecured;

- (void)setTitle:(NSString *)_title;
- (void)setDescription:(NSString *)_description;
- (void)setIdPack:(int)_idPack;
- (void)setIsFree:(BOOL)free;

@end