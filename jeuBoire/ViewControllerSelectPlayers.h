//
//  ViewControllerSelectPlayers.h
//  jeuBoire
//
//  Created by Kévin MACHADO on 14/01/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayersListSV;
@class ChoosePackAndStarGameView;

@interface ViewControllerSelectPlayers : UIViewController <UIScrollViewDelegate>
{
    IBOutlet UIStepper *playerStepper;
    IBOutlet UILabel *playersLabel;
    
    ChoosePackAndStarGameView *chooseStarView;
}

@property (nonatomic, strong) UIView *mainBackgroundView;
@property (nonatomic, strong) UIView *bottomBackgroundView;
@property (nonatomic, strong) UIView *endBackgroundView;

@property (nonatomic, strong) UIScrollView *scrollViewContainer;
@property (nonatomic, strong) PlayersListSV *playersListScrollView;
@property (nonatomic, assign) CGFloat screenHeight;
@property (nonatomic, assign) CGFloat screenWidth;

- (void)valueChanged:(UIStepper *)sender;
- (void)launchGameViewController;

@end