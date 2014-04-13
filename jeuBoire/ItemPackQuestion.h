//
//  ItemQuestion.h
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 08/04/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemPackQuestion : NSObject
{
    NSString *title;
    NSString *description;
    int idPack;
    //NSString *image;
}

- (NSString *)title;
- (NSString *)description;
- (NSString *)idPack;

- (void)setTitle:(NSString *)_title;
- (void)setDescription:(NSString *)_description;
- (void)setIdPack:(int)_idPack;

@end