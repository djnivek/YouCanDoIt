//
//  PlayerProfilView.m
//  jeuBoire
//
//  Created by Kévin MACHADO on 27/02/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "PlayerProfilView.h"

@implementation PlayerProfilView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor redColor]];
        [self setAlpha:0.3];
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
    CGRect labelFrame = CGRectMake((screenFrame.size.width/2)-(labelWidth/2),
                                   (screenFrame.size.height/2)-(labelHeight/2),
                                   labelWidth,
                                   labelHeight);
    
    UILabel *playerNumLabel = [[UILabel alloc] initWithFrame:labelFrame];
    playerNumLabel.backgroundColor = [UIColor clearColor];
    playerNumLabel.textColor = [UIColor whiteColor];
    playerNumLabel.text = [NSString stringWithFormat:@"%d", 1];
    playerNumLabel.textAlignment = NSTextAlignmentCenter;
    playerNumLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:120];
    [self addSubview:playerNumLabel];
    
    //  Set TextField
    CGFloat txtFieldHeight = 40;
    CGFloat txtFieldWidth = 150;
    CGRect txtFieldFrame = CGRectMake((screenFrame.size.width/2)-(txtFieldWidth/2),
                                   (screenFrame.size.height/2)-(txtFieldHeight/2),
                                   txtFieldWidth,
                                   txtFieldHeight);
    UITextField *playerNameTxtField = [[UITextField alloc] initWithFrame:txtFieldFrame];
    playerNameTxtField.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:120];
    [self addSubview:playerNameTxtField];
}


@end
