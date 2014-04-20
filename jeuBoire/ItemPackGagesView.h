//
//  ItemQuestionView.h
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 08/04/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemPackGages;
@class CheckmarkView;

@interface ItemPackGagesView : UIView
{
    UILabel *label;
    ItemPackGages *item;
    CheckmarkView *checkmarkView;
    BOOL selected;
}

- (void)setItem:(ItemPackGages *)pkQ;
- (void)setEnable:(BOOL)enable;

- (ItemPackGages *)item;
- (BOOL)isSelected;

@end
