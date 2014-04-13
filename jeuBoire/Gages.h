//
//  Gages.h
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 19/03/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Gage;

@interface Gages : NSObject
{
    NSMutableDictionary *dictionary;
}

/**
 Retourne la liste des gages pour le
 niveau renseigné sur l'idPack entré
 **/
- (NSArray *)getForIdPack:(int)idPack level:(int)level;

/**
 Retourne la liste des gages pour l'idPack
 renseigné
 **/
- (NSArray *)getForIdPack:(int)idPack;

/**
 Retourne les identifiants des packs
 contenus
 **/
- (NSArray *)getIdPackContained;

- (void)addGage:(Gage *)gage;

- (BOOL)containsGages;

- (void)saveToLocal;

- (void)loadFromLocal;

- (void)loadFromWeb:(void (^)(void))completion onFailed:(void (^)(void))fail andForce:(BOOL)force;

//- (void)isUpdateRequired:(void(^)(BOOL))required;
 
@end
