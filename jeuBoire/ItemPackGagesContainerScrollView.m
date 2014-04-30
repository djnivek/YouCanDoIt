//
//  ItemQuestionContainerScrollView.m
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 08/04/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "ItemPackGagesContainerScrollView.h"
#import "ItemPackView.h"
#import "ItemPack.h"

@implementation ItemPackGagesContainerScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        itemViewStack = [[NSMutableArray alloc] init];
        frameEdge = self.frame.size.height;
        [self setPagingEnabled:YES];
    }
    return self;
}

- (void)addItemView:(ItemPack *)item {
    CGFloat xOrigin = frameEdge*[itemViewStack count];
    ItemPackView *pckView = [[ItemPackView alloc] initWithFrame:CGRectMake(xOrigin, 0, frameEdge, frameEdge)];
    [pckView setMainDelegate:_theDelegate];
    [self addSubview:pckView];
    [pckView setItem:item];
    [itemViewStack addObject:pckView];
    [self setContentSize:[self actualSize]];
}

- (CGSize)actualSize {
    return CGSizeMake(frameEdge*[itemViewStack count], frameEdge);
}

- (NSArray *)selectedItems {
    NSMutableArray *selectedItems = [[NSMutableArray alloc] init];
    for (ItemPackView *iPGView in itemViewStack) {
        if ([iPGView isSelected]) {
            [selectedItems addObject:[iPGView item]];
        }
    }
    return (NSArray *)selectedItems;
}

- (BOOL)isSelectedItem {
    for (ItemPackView *iPQView in itemViewStack) {
        if ([iPQView isSelected]) {
            return TRUE;
        }
    }
    return FALSE;
}

- (void)setTheDelegate:(ViewControllerSelectPlayers*)delegate {
    _theDelegate = delegate;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end