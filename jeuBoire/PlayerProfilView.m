//
//  PlayerProfilView.m
//  jeuBoire
//
//  Created by Kévin MACHADO on 27/02/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "PlayerProfilView.h"
#define dyELEMENT 50

@implementation PlayerProfilView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        //  Init Label
        self.playerNum = [[UILabel alloc] init];
        
        //  Init Textfield
        self.playerName = [[UITextField alloc] init];
        
        //  Init SegmentedControl
        self.playerSex = [[UISegmentedControl alloc] initWithItems:@[@"Man", @"Woman"]];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGRect screenFrame = [UIScreen mainScreen].bounds;
 
    //  Set Label
    CGFloat labelHeight = 100;
    CGFloat labelWidth = 150;
    CGRect labelFrame = CGRectMake((screenFrame.size.width)-(labelWidth),
                                   (labelHeight/2),
                                   labelWidth,
                                   labelHeight);
    
    [self.playerNum setFrame:labelFrame];
    [self.playerNum setBackgroundColor:[UIColor clearColor]];
    [self.playerNum setTextColor:[UIColor whiteColor]];
    [self.playerNum setTextAlignment:NSTextAlignmentRight];
    [self.playerNum setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:120]];
    [self addSubview:self.playerNum];
    
    //  Set TextField
    CGFloat txtFieldHeight = 40;
    CGFloat txtFieldWidth = 150;
    CGRect txtFieldFrame = CGRectMake((screenFrame.size.width/2)-(txtFieldWidth/2),
                                   (screenFrame.size.height/2)-(txtFieldHeight/2),
                                   txtFieldWidth,
                                   txtFieldHeight);
    [self.playerName setFrame:txtFieldFrame];
    [self.playerName setPlaceholder:@"Surname"];
    [self.playerName setTextAlignment:NSTextAlignmentCenter];
    [self.playerName setTextColor:[UIColor blackColor]];
    [self.playerName setDelegate:self];
    [self.playerName setReturnKeyType:UIReturnKeyDone];
    [self.playerName setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
    [self addSubview:self.playerName];
    
    //  Set SegmentedControl
    CGPoint segmentedControlPoint = CGPointMake((screenFrame.size.width/2),
                                             txtFieldFrame.origin.y+txtFieldFrame.size.height+dyELEMENT);
    [self.playerSex setCenter:segmentedControlPoint];
    [self addSubview:self.playerSex];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.playerName resignFirstResponder];
    return true;
}


@end
