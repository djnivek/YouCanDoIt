//
//  PlayersListSV.h
//  jeuBoire
//
//  Created by Kévin MACHADO on 28/02/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayersListSV : UIScrollView
{
    NSMutableArray *playerViewStack;
    CGFloat screenWidth;
    CGFloat screenHeight;
}

- (void)addPlayerView;
- (void)removeLastPlayerView;
- (int)nbPlayers;

- (NSArray *)players;

@end
