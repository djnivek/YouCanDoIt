//
//  GageController.h
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 17/03/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GageFields;
@class Gage;
@class Gages;

@interface GageController : NSObject
{
    GageFields *gageFields;
    Gages *gagesLibrary;
    
    Gage *currentGage;
}

- (id)initWithGageFields:(GageFields *)_fields andGages:(Gages *)_gages;

- (void)hiddeGageLayout:(BOOL)hiddeIt;

- (BOOL)containGages;

- (void)otherGageWithLevel:(int)level;

@end
