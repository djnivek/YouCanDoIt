//
//  ViewControllerSelectPlayers.m
//  jeuBoire
//
//  Created by Kévin MACHADO on 14/01/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "ViewControllerSelectPlayers.h"
#import <LBBlurredImage/UIImageView+LBBlurredImage.h>
#import "PlayerProfilView.h"
#import "PlayersListSV.h"
#import "ViewControllerGame.h"
#import "GameSession.h"
#import "ChoosePackAndStarGameView.h"

@interface ViewControllerSelectPlayers ()

@end

#define MAX_PLAYERS 12
#define MIN_PLAYERS 2
#define NUMBER_OF_VIEW 3

@implementation ViewControllerSelectPlayers

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)valueChanged:(UIStepper *)sender {
    
    double value = [sender value];
    
    if (value > MAX_PLAYERS)
        [sender setValue:MAX_PLAYERS];
    else if (value < MIN_PLAYERS)
        [sender setValue:MIN_PLAYERS];
    
    value = [sender value];
    
    [playersLabel setText:[NSString stringWithFormat:@"%d", (int)value]];
    
    if ((int)value > [self.playersListScrollView nbPlayers])
        [self.playersListScrollView addPlayerView];
    else
        [self.playersListScrollView removeLastPlayerView];
}

#pragma mark - VIEW -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect screenFrame = [UIScreen mainScreen].bounds;

    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.mainBackgroundView = [[UIView alloc] initWithFrame:screenFrame];
    [self.mainBackgroundView setBackgroundColor:[UIColor cyanColor]];
    [self.view addSubview:self.mainBackgroundView];
    
    self.bottomBackgroundView = [[UIView alloc] initWithFrame:screenFrame];
    [self.bottomBackgroundView setBackgroundColor:[UIColor redColor]];
    self.bottomBackgroundView.alpha = 0;
    [self.view addSubview:self.bottomBackgroundView];
    
    self.endBackgroundView = [[UIView alloc] initWithFrame:screenFrame];
    [self.endBackgroundView setBackgroundColor:[UIColor greenColor]];
    self.endBackgroundView.alpha = 0;
    [self.view addSubview:self.endBackgroundView];
    
    
    
#pragma mark - ScrollView -
    
    //  Add ScrollView
    
    CGRect scrollViewFrame = CGRectMake(0, 0, self.screenWidth, self.screenHeight);
    CGSize scrollViewSize = CGSizeMake(self.screenWidth, self.screenHeight*NUMBER_OF_VIEW);
    self.scrollViewContainer = [[UIScrollView alloc] initWithFrame:scrollViewFrame];
    self.scrollViewContainer.delegate = self;
    self.scrollViewContainer.backgroundColor = [UIColor clearColor];
    [self.scrollViewContainer setContentSize:scrollViewSize];
    [self.scrollViewContainer setPagingEnabled:YES];
    [self.view addSubview:self.scrollViewContainer];
    
    /**/
    
    
#pragma mark TopView
    
    //  Define frame for top
    
    CGFloat inset = 80;
    
    CGFloat labelHeight = 100;
    CGFloat labelWidth = 150;
    
    CGRect labelFrame = CGRectMake((screenFrame.size.width/2)-(labelWidth/2),
               (screenFrame.size.height/2)-(labelHeight/2),
               labelWidth,
               labelHeight);
    
    CGPoint stepperPoint = CGPointMake(screenFrame.size.width/2,
                                       (screenFrame.size.height/2)+inset);
    
    //  Add TopView to ScrollView
    UIView *selectNumberPlayersView = [[UIView alloc] initWithFrame:screenFrame];
    [self.scrollViewContainer addSubview:selectNumberPlayersView];
    
    //  Add content on HeaderView
    // center top
    playersLabel = [[UILabel alloc] initWithFrame:labelFrame];
    playersLabel.backgroundColor = [UIColor clearColor];
    playersLabel.textColor = [UIColor whiteColor];
    playersLabel.text = [NSString stringWithFormat:@"%d", MIN_PLAYERS];
    playersLabel.textAlignment = NSTextAlignmentCenter;
    playersLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:120];
    [selectNumberPlayersView addSubview:playersLabel];
    
    // center bottom
    playerStepper = [[UIStepper alloc] init];
    [playerStepper addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [playerStepper setCenter:stepperPoint];
    [playerStepper setMinimumValue:MIN_PLAYERS];
    [playerStepper setMaximumValue:MAX_PLAYERS];
    [selectNumberPlayersView addSubview:playerStepper];
    
    /**/
    
#pragma mark PlayerView
    
    //  Add BottomView to ScrollView
    UIView *playerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.screenHeight, self.screenWidth, self.screenHeight)];
    [self.scrollViewContainer addSubview:playerView];
    
#pragma mark - MiddleScrollView -
#pragma mark >> PlayerView
    
    self.playersListScrollView = [[PlayersListSV alloc] initWithFrame:CGRectMake(0, 0, self.screenWidth, self.screenHeight)];
    [playerView addSubview:self.playersListScrollView];
    
#pragma mark EndView
    
    chooseStarView = [[ChoosePackAndStarGameView alloc]
                                          initWithFrame: CGRectMake(0, self.screenHeight*2, self.screenWidth, self.screenHeight)];
    [self.scrollViewContainer addSubview:chooseStarView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    self.mainBackgroundView.frame = bounds;
    self.bottomBackgroundView.frame = bounds;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat height = scrollView.bounds.size.height;

    CGFloat position = MAX(scrollView.contentOffset.y, 0.0);
    
    CGFloat percent = MIN(position / height, 2.0);
    
    self.bottomBackgroundView.alpha = percent;
    self.endBackgroundView.alpha = (percent > 1 ? percent-1 : 0);
}

#pragma mark - view actions -

- (void)launchGameViewController {
    ViewControllerGame *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"GameControllerIdentifier"];
    controller.passingPlayers = [[NSMutableArray alloc] initWithArray:[self.playersListScrollView players]];
    NSLog(@"ViewControllerSelectPlayers || launchGameViewController || %@", [chooseStarView selectedItems]);
    controller.passingPackAvalaible = [chooseStarView selectedItems];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
