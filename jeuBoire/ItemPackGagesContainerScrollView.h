//
//  ItemQuestionContainerScrollView.h
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 08/04/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemPack;
@class ViewControllerSelectPlayers;

@interface ItemPackGagesContainerScrollView : UIScrollView
{
    NSMutableArray *itemViewStack;
    CGFloat frameEdge;
    
    ViewControllerSelectPlayers *_theDelegate;
}

- (void)addItemView:(ItemPack *)item;
- (NSArray *)selectedItems;
- (BOOL)isSelectedItem;
- (void)setTheDelegate:(ViewControllerSelectPlayers*)delegate;

@end
