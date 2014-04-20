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
        self.frame = CGRectMake(0, 0, 33, 33);
        //// Color Declarations
        white = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
        blue = [UIColor colorWithRed: 0.343 green: 0.562 blue: 1 alpha: 1];
        invisible = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0];
        [self setBackgroundColor:[UIColor clearColor]];
        activated = FALSE;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if (!activated)
        [self initialDraw];
    else
        [self blueCheckMark];
}

- (void)setEnable {
    activated = TRUE;
    [self setNeedsDisplay];
}

- (void)blueCheckMark {
    [blue setFill];
    [ovalPath fill];
    
    //// Bezier Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(8.5, 18.28)];
    [bezierPath addLineToPoint: CGPointMake(14.5, 23.5)];
    [bezierPath addLineToPoint: CGPointMake(26.5, 11.5)];
    [white setStroke];
    bezierPath.lineWidth = 2;
    [bezierPath stroke];
}

- (void)initialDraw {
    //// Oval Drawing
    ovalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.5, 0.5, 32, 32)];
    [invisible setFill];
    [ovalPath fill];
    [white setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
    
    bezierPath = [UIBezierPath bezierPath];
}

- (void)setSecure {
    
}

- (void)setDisable {
    activated = FALSE;
    [self setNeedsDisplay];
}

- (BOOL)isActivated {
    return activated;
}

@end
