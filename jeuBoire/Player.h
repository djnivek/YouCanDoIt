//
//  Player.h
//  jeuBoire
//
//  Created by Kévin MACHADO on 19/01/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject
{
    int idPlayer;
    NSString *name;
    BOOL sex; //Man = 1 & Woman = 0
}

@end
