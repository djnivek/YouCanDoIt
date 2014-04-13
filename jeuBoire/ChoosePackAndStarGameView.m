//
//  ChoosePackAndStarGameView.m
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 11/04/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "ChoosePackAndStarGameView.h"
#import "ViewControllerSelectPlayers.h"
#import "ItemPackQuestionContainerScrollView.h"
#import "ItemPackQuestion.h"
@implementation ChoosePackAndStarGameView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        packQScrollView = [[ItemPackQuestionContainerScrollView alloc] init];
        
        ItemPackQuestion *pQ1 = [[ItemPackQuestion alloc] init];
        [pQ1 setTitle:@"Sport"];
        ItemPackQuestion *pQ2 = [[ItemPackQuestion alloc] init];
        [pQ2 setTitle:@"Cars"];
        ItemPackQuestion *pQ3 = [[ItemPackQuestion alloc] init];
        [pQ3 setTitle:@"IT"];
        ItemPackQuestion *pQ4 = [[ItemPackQuestion alloc] init];
        [pQ4 setTitle:@"Movies"];
        ItemPackQuestion *pQ5 = [[ItemPackQuestion alloc] init];
        [pQ5 setTitle:@"Music"];
        
        CGRect frame = CGRectMake(0, 50, self.frame.size.width, 200);
        ItemPackQuestionContainerScrollView *scrollView = [[ItemPackQuestionContainerScrollView alloc] initWithFrame:frame];
        [self addSubview:scrollView];
        [scrollView addItemView:pQ1];
        [scrollView addItemView:pQ2];
        [scrollView addItemView:pQ3];
        [scrollView addItemView:pQ4];
        [scrollView addItemView:pQ5];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGFloat buttonWidth = 120;
    CGFloat buttonHeight = 50;
    CGRect buttonFrame = CGRectMake((self.frame.size.width/2)-(buttonWidth/2),
                                    (self.frame.size.height/2)-(buttonHeight/2),
                                    buttonWidth,
                                    buttonHeight);
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    [button setTitle:@"Let's play" forState:UIControlStateNormal];
    [button addTarget:delegate action:@selector(launchGameViewController) forControlEvents:UIControlEventTouchDown];
    [self addSubview:button];
}

@end
