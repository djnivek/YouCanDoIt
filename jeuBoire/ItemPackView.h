//
//  ItemQuestionView.h
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 08/04/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemPack;
@class CheckmarkView;
@class ViewControllerSelectPlayers;

@interface ItemPackView : UIView
{
    UILabel *label;
    ItemPack *item;
    CheckmarkView *checkmarkView;
    
    ViewControllerSelectPlayers* mainDelegate;
}

- (void)setItem:(ItemPack *)pkQ;
- (void)setEnable:(BOOL)enable;
- (void)setMainDelegate:(ViewControllerSelectPlayers*)delegate;

- (ItemPack *)item;
- (BOOL)isSelected;
- (BOOL)isSecured;

@end
