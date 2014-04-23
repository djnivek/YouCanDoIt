//
//  ChoosePackAndStarGameView.h
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 11/04/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewControllerSelectPlayers;
@class ItemPackQuestionContainerScrollView;
@class ItemPackGagesContainerScrollView;

@interface ChoosePackAndStarGameView : UIView
{
    ViewControllerSelectPlayers *delegate;
    
    //  PackQuestions
    ItemPackQuestionContainerScrollView *packQRScrollView;
    
    //  PackGages
    ItemPackGagesContainerScrollView *packGScrollView;
}

//  Dictionnaire des packs selectionnés - Rangé par clées ("questions" - "gages")
- (NSDictionary *)selectedItems;
- (BOOL)isSelectedPacks;

@end
