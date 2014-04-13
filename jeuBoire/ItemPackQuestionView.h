//
//  ItemQuestionView.h
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 08/04/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemPackQuestion;
@class CheckmarkView;

@interface ItemPackQuestionView : UIView
{
    UILabel *label;
    ItemPackQuestion *item;
    CheckmarkView *checkmarkView;
}

- (void)setItem:(ItemPackQuestion *)pkQ;
- (void)setEnable:(BOOL)enable;

@end
