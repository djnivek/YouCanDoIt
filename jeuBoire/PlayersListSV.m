//
//  PlayersListSV.m
//  jeuBoire
//
//  Created by Kévin MACHADO on 28/02/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "PlayersListSV.h"
#import "PlayerProfilView.h"
#import "Player.h"

@implementation PlayersListSV

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        playerViewStack = [[NSMutableArray alloc] init];
        screenHeight = [UIScreen mainScreen].bounds.size.height;
        screenWidth = [UIScreen mainScreen].bounds.size.width;
        [self setBackgroundColor:[UIColor clearColor]];
        [self setPagingEnabled:YES];
        [self addPlayerView];
        [self addPlayerView];
    }
    return self;
}

#pragma mark - ADD -

- (void)addPlayerView {
    CGFloat xOrigin = [playerViewStack count]*screenWidth;
    PlayerProfilView *profilView = [[PlayerProfilView alloc] initWithFrame:CGRectMake(xOrigin, 0, screenWidth, screenHeight)];
    [profilView.playerNum setText:[NSString stringWithFormat:@"%d", (int)[playerViewStack count]+1]];
    [self addSubview:profilView];
    [playerViewStack addObject:profilView];
    [self setContentSize:[self actualSize]];
}

#pragma mark - REMOVE -

- (void)removeLastPlayerView {
    [[playerViewStack lastObject] removeFromSuperview];
    [playerViewStack removeLastObject];
    [self setContentSize:[self actualSize]];
}

- (CGSize)actualSize {
    return CGSizeMake(screenWidth*[playerViewStack count], screenHeight);
}

- (int)nbPlayers {
    return (int)[playerViewStack count];
}

- (NSArray *)players {
    NSMutableArray *players = [[NSMutableArray alloc] init];
    for (PlayerProfilView *pfView in playerViewStack) {
        
        Player *p = [[Player alloc] initWithName:pfView.playerName.text idPlayer:[pfView.playerNum.text intValue] sex:pfView.playerSex.selected];
        [players addObject:p];
    }
    return players;
}

@end
