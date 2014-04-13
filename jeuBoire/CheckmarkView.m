//
//  CheckmarkView.m
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 10/04/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "CheckmarkView.h"

@implementation CheckmarkView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 66, 66);
        //// Color Declarations
        white = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
        blue = [UIColor colorWithRed: 0.343 green: 0.562 blue: 1 alpha: 1];
        invisible = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    NSLog(@" ---- > Yo !");
    [self setDisable];
}

- (void)setEnable {
    NSLog(@" -----> test");
    [blue setFill];
    [ovalPath fill];
    
    //// Bezier Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(15.5, 35.5)];
    [bezierPath addLineToPoint:CGPointMake(27.5, 45.5)];
    [bezierPath addLineToPoint:CGPointMake(51.5, 22.5)];
    [white setStroke];
    bezierPath.lineWidth = 2;
    [bezierPath stroke];
}

- (void)setSecure {
    
}

- (void)setDisable {
    //// Oval Drawing
    ovalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.5, 0.5, 64, 64)];
    [invisible setFill];
    [ovalPath fill];
    [white setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
    
    bezierPath = [UIBezierPath bezierPath];
}

@end
