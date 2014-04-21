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
#import "ItemPackGages.h"

@implementation GageController

- (id)initWithGageFields:(GageFields *)_fields andGages:(Gages *)_gages {
    self = [super init];
    if (self) {
        gageFields = _fields;
        gagesLibrary = _gages;
    }
    return self;
}

- (void)setPackGageAvalaible:(NSArray *)_packGage {
    packGageAvalaible = _packGage;
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
    
    int idPackRandom = [self findIdPackAmongAvailable];
    NSArray *array = [gagesLibrary getForIdPack:idPackRandom level:level];
    int r = arc4random() % [array count];
    
    if ([array count]) {
        currentGage = (Gage *)[array objectAtIndex:r];
        return currentGage;
    }
    
    return NULL;
}

- (int)findIdPackAmongAvailable {
    // Permet de trouver l'identifiant d'un pack aléatoire parmi les packs selectionnés
    int random = arc4random() % [packGageAvalaible count];
    ItemPackGages *pck = [packGageAvalaible objectAtIndex:random];
    return [[pck idPack] intValue];
}

- (int)currentGageDuration {
    return [currentGage getDuration];
}

@end
