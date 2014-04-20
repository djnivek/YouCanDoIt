//
//  PackGages.h
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 13/04/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Gage;

@interface PackGages : NSObject
{
    int idPackGage;
    NSString *titre;
    NSString *description;
    NSMutableArray *gageList;
}

- (id)initWithIdPack:(int)idPack;

- (void)addGage:(Gage *)g;

- (NSArray *)gagesWithLevel:(int)level;
- (NSArray *)gages;
- (NSString *)title;

@end
