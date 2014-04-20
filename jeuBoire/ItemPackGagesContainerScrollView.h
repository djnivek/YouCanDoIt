//
//  ItemQuestionContainerScrollView.h
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 08/04/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemPackGages;

@interface ItemPackGagesContainerScrollView : UIScrollView
{
    NSMutableArray *itemViewStack;
    CGFloat frameEdge;
}

- (void)addItemView:(ItemPackGages *)item;
- (NSArray *)selectedItems;

@end
