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

@interface ViewControllerSelectPlayers ()

@end

#define MAX_PLAYERS 12
#define MIN_PLAYERS 2
#define NUMBER_OF_VIEW 2

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
    
    if (value > MAX_PLAYERS) {
        [sender setValue:MAX_PLAYERS];
        value = [sender value];
    }
    if (value < MIN_PLAYERS) {
        [sender setValue:MIN_PLAYERS];
        value = [sender value];
    }
    
    [playersLabel setText:[NSString stringWithFormat:@"%d", (int)value]];
}

#pragma mark - VIEW -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect screenFrame = [UIScreen mainScreen].bounds;
    NSLog(@"%f", screenFrame.size.width);
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    UIImage *background = [UIImage imageNamed:@"bg"];
    
    self.backgroundImageView = [[UIImageView alloc] initWithImage:background];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.backgroundImageView];
    
    self.blurredImageView = [[UIImageView alloc] init];
    self.blurredImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.blurredImageView.alpha = 0;
    [self.blurredImageView setImageToBlur:background blurRadius:10 completionBlock:nil];
    [self.view addSubview:self.blurredImageView];
    
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
    UIView *topView = [[UIView alloc] initWithFrame:screenFrame];
    [self.scrollViewContainer addSubview:topView];
    
    //  Add content on HeaderView
    // center top
    playersLabel = [[UILabel alloc] initWithFrame:labelFrame];
    playersLabel.backgroundColor = [UIColor clearColor];
    playersLabel.textColor = [UIColor whiteColor];
    playersLabel.text = [NSString stringWithFormat:@"%d", MIN_PLAYERS];
    playersLabel.textAlignment = NSTextAlignmentCenter;
    playersLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:120];
    [topView addSubview:playersLabel];
    
    // center bottom
    playerStepper = [[UIStepper alloc] init];
    [playerStepper addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [playerStepper setCenter:stepperPoint];
    [playerStepper setMinimumValue:MIN_PLAYERS];
    [playerStepper setMaximumValue:MAX_PLAYERS];
    [topView addSubview:playerStepper];
    
    /**/
    
#pragma mark BottomView
    
    //  Add BottomView to ScrollView
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.screenHeight, self.screenWidth, self.screenHeight)];
    [self.scrollViewContainer addSubview:bottomView];
    
#pragma mark > BottomScrollView
    
    // Add ScrollView to BottomView
    int numberBottomScrollView = 2;
    
    CGRect bottomScrollViewFrame = CGRectMake(0, 0, self.screenWidth, self.screenHeight);
    CGSize bottomScrollViewSize = CGSizeMake(self.screenWidth*numberBottomScrollView, self.screenHeight);
    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:bottomScrollViewFrame];
    [bottomScrollView setPagingEnabled:YES];
    bottomScrollView.backgroundColor = [UIColor clearColor];
    
#pragma mark >> PlayerView
    
    NSMutableArray *playerViewStack = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < numberBottomScrollView; i++) {
        CGFloat xOrigin = i*self.screenWidth;
        PlayerProfilView *profilView = [[PlayerProfilView alloc] initWithFrame:CGRectMake(xOrigin, 0, self.screenWidth, self.screenHeight)];
    
        [bottomScrollView addSubview:profilView];
        [bottomScrollView setAlpha:0.3];
        [playerViewStack addObject:profilView];
    }
    
    //  Refresh content ScrollView
    [bottomScrollView setContentSize:bottomScrollViewSize];
    [bottomView addSubview:bottomScrollView];
    //[bottomScrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, self.screenWidth*(numberBottomScrollView-1))];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGRect bounds = self.view.bounds;
    
    self.backgroundImageView.frame = bounds;
    self.blurredImageView.frame = bounds;
}

#pragma mark - UITABLEVIEW -

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [playerStepper value]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.section == 0 && indexPath.row == 0)
        [self configureHeaderCell:cell title:@"Joueurs"];
    //else
        
        
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat height = scrollView.bounds.size.height;
    
    CGFloat position = MAX(scrollView.contentOffset.y, 0.0);
    
    CGFloat percent = MIN(position / height, 1.0);
    
    self.blurredImageView.alpha = percent;
}

#pragma mark - Cell

- (void)configureHeaderCell:(UITableViewCell *)cell title:(NSString *)title {
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
    cell.textLabel.text = title;
    cell.detailTextLabel.text = @"";
    cell.imageView.image = nil;
}

@end
