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

@interface ChoosePackAndStarGameView : UIView
{
    ViewControllerSelectPlayers *delegate;
    
    //  PackQuestions
    ItemPackQuestionContainerScrollView *packQScrollView;
    
    //  PackGages
//    ItemPackQuestionContainerScrollView *packQScrollView;
}

@end
