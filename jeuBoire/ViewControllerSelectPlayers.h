//
//  ViewControllerSelectPlayers.h
//  jeuBoire
//
//  Created by Kévin MACHADO on 14/01/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerSelectPlayers : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
{
    IBOutlet UIStepper *playerStepper;
    IBOutlet UILabel *playersLabel;
}

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *blurredImageView;
@property (nonatomic, strong) UIScrollView *scrollViewContainer;
@property (nonatomic, assign) CGFloat screenHeight;
@property (nonatomic, assign) CGFloat screenWidth;

- (IBAction)valueChanged:(UIStepper *)sender;

@end