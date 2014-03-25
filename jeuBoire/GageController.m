//
//  GageController.m
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 17/03/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "GageController.h"
#import "GageFields.h"
#import "Gage.h"
#import "Gages.h"

@implementation GageController

- (id)initWithGageFields:(GageFields *)_fields andGages:(Gages *)_gages {
    self = [super init];
    if (self) {
        gageFields = _fields;
        gagesLibrary = _gages;
    }
    return self;
}

- (void)hiddeGageLayout:(BOOL)hiddeIt {
    [gageFields hiddeGageLayout:hiddeIt];
}

- (BOOL)containGages {
    return [gagesLibrary containsGages];
}

- (void)otherGageWithLevel:(int)level {
    [gageFields hiddeGageLayout:FALSE];
    Gage *gage = [self pullGageForLevel:level];
    [gageFields setText:[gage getDescription]];
}

- (Gage *)pullGageForLevel:(int)level {
    
    //Sauf si l'utilisateur à payé le pack + qui permet de brider quelques gages pour lui même.
    //L'utilisateur choisi le nom qui sera toujours bridé et SI currentplayer.name = packplus.namebride ALORS SI gage = gagebridés ALORS
    //nouveau tirage
    
    int idPackWanted = 1;
    NSLog(@"GageController || %d - %d", idPackWanted, level);
    NSArray *array = [gagesLibrary getForIdPack:idPackWanted level:level];
    NSLog(@"GageController || %d", [array count]);
    int r = arc4random() % [array count];
    
    if ([array count]) {
        return (Gage *)[array objectAtIndex:r];
    }
    
    return NULL;
}

@end
