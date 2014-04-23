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
#import "ItemPackGagesContainerScrollView.h"

#import "ItemPack.h"

#import "AppDelegate.h"

#import "Gages.h"
#import "PackGages.h"

#import "QRLibrary.h"
#import "PackQRs.h"

@implementation ChoosePackAndStarGameView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        
        CGRect frameQRScrollView = CGRectMake(0, 50, self.frame.size.width, 200);
        packQRScrollView = [[ItemPackQuestionContainerScrollView alloc] initWithFrame:frameQRScrollView];
        [self addSubview:packQRScrollView];
        
        NSArray *packQuestionsContained = [[(AppDelegate *)[[UIApplication sharedApplication] delegate] questionsListe] getPackContained];
        for (PackQRs *pQR in packQuestionsContained) {
            ItemPack *pQ = [[ItemPack alloc] init];
            [pQ setTitle:[pQR title]];
            [pQ setIdPack:[[pQR getID] intValue]];
            [pQ setIsFree:[pQR isFree]];
            [packQRScrollView addItemView:pQ];
        }
        
        CGRect frameGSScrollView = CGRectMake(0, self.frame.size.height-50-(200/2), self.frame.size.width, 200);
        packGScrollView = [[ItemPackGagesContainerScrollView alloc] initWithFrame:frameGSScrollView];
        [self addSubview:packGScrollView];
        
        NSArray *packGagesContained = [[(AppDelegate *)[[UIApplication sharedApplication] delegate] gagesList] getPackContained];
        for (PackGages *pG in packGagesContained) {
            ItemPack *ipG = [[ItemPack alloc] init];
            [ipG setTitle:[pG title]];
            [ipG setIdPack:[[pG getID] intValue]];
            [ipG setIsFree:[pG isFree]];
            [packGScrollView addItemView:ipG];
        }
        
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

- (NSDictionary *)selectedItems {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [packQRScrollView selectedItems], @"pack_questions",
            [packGScrollView selectedItems], @"pack_gages",
            nil];
}

- (BOOL)isSelectedPacks {
    return ([packGScrollView isSelectedItem] && [packQRScrollView isSelectedItem]);
}

@end
