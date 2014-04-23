//
//  ItemQuestionContainerScrollView.h
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 08/04/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemPack;

@interface ItemPackQuestionContainerScrollView : UIScrollView
{
    NSMutableArray *itemViewStack;
    CGFloat frameEdge;
}

- (void)addItemView:(ItemPack *)item;
- (NSArray *)selectedItems;
- (BOOL)isSelectedItem;

@end
