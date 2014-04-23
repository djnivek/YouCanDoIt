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

@interface ItemPackQuestionView : UIView
{
    UILabel *label;
    ItemPack *item;
    CheckmarkView *checkmarkView;
}

- (void)setItem:(ItemPack *)pkQ;
- (void)setEnable:(BOOL)enable;

- (ItemPack *)item;
- (BOOL)isSelected;
- (BOOL)isSecured;
- (int)idPack;

@end
