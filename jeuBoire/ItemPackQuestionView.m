//
//  ItemQuestionView.m
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 08/04/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "ItemPackQuestionView.h"
#import "ItemPackQuestion.h"
#import "CheckmarkView.h"

#define COEF_DIV 1.3

@implementation ItemPackQuestionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        label = [[UILabel alloc] init];
        item = [[ItemPackQuestion alloc] init];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetAlpha(context, 1);
    
    CGFloat x = (self.frame.size.width/2)-((self.frame.size.width/COEF_DIV)/2);
    CGFloat y = (self.frame.size.height/2)- ((self.frame.size.height/COEF_DIV)/2);
    CGContextFillEllipseInRect(context, CGRectMake(x,y,self.frame.size.width/COEF_DIV,self.frame.size.height/COEF_DIV));
    
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextStrokeEllipseInRect(context, CGRectMake(x,y,self.frame.size.width/COEF_DIV,self.frame.size.height/COEF_DIV));
    
    CGRect labelFrame = CGRectMake(0,0,140,30);
    [label setFrame:labelFrame];
    [label setCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor blackColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-Regular" size:16]];
    [self addSubview:label];
    
    [self addCheckMark];
}

- (void)addCheckMark {
    checkmarkView = [[CheckmarkView alloc] init];
    CGFloat x = (self.frame.size.width/2)+((self.frame.size.width/COEF_DIV)/2)-20;
    CGFloat y = (self.frame.size.height/2)-((self.frame.size.height/COEF_DIV)/2)+20;
    [checkmarkView setCenter:CGPointMake(x, y)];
    [self addSubview:checkmarkView];
}

#pragma mark - EVENT -

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![item isSecured])
        [self setEnable:![checkmarkView isActivated]];
}

#pragma mark - ACCESSORS -

- (void)setEnable:(BOOL)enable {
    if (!checkmarkView)
        [self addCheckMark];
    
    if (enable)
        [checkmarkView setEnable];
    else
        [checkmarkView setDisable];
}

- (void)setItem:(ItemPackQuestion *)pkQ {
    item = pkQ;
    [label setText:[item title]];
}

- (ItemPackQuestion *)item {
    return item;
}

- (BOOL)isSelected {
    return [checkmarkView isActivated];
}

- (int)idPack {
    return [[item idPack] intValue];
}

@end