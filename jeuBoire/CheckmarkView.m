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
        gray = [UIColor colorWithRed: 0.667 green: 0.667 blue: 0.667 alpha: 1];
        [self setBackgroundColor:[UIColor clearColor]];
        activated = FALSE;
        secured = FALSE;
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
    if (secured)
        [self secureCheckmark];
}

- (void)blueCheckMark {
    [self drawBlueOval];
    
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
    [self drawInvisibleOval];
}

- (void)drawInvisibleOval {
    //// Oval Drawing
    ovalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.5, 0.5, 32, 32)];
    [invisible setFill];
    [ovalPath fill];
    [white setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
    
    bezierPath = [UIBezierPath bezierPath];
}

- (void)drawBlueOval {
    [blue setFill];
    [ovalPath fill];
}

- (void)drawGrayOval {
    //// Oval Drawing
    ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0.5, 0.5, 32, 32)];
    [gray setFill];
    [ovalPath fill];
    [white setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
}

- (void)drawSecureShape {
    //// Rectangle Drawing
    UIBezierPath *rectangleCadena = [UIBezierPath bezierPathWithRect: CGRectMake(9, 14.5, 15, 9)];
    [[UIColor whiteColor] setFill];
    [rectangleCadena fill];
    [white setStroke];
    rectangleCadena.lineWidth = 1;
    [rectangleCadena stroke];
    
    //// Oval 2 Drawing
    UIBezierPath *topLock = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(15, 16.5, 3, 2)];
    [gray setFill];
    [topLock fill];
    
    //// Bezier 2 Drawing
    UIBezierPath *bottomLock = [UIBezierPath bezierPath];
    [bottomLock moveToPoint: CGPointMake(16, 18)];
    [bottomLock addLineToPoint: CGPointMake(15, 21)];
    [bottomLock addLineToPoint: CGPointMake(18, 21)];
    [bottomLock addLineToPoint: CGPointMake(17, 18)];
    [bottomLock addLineToPoint: CGPointMake(16, 18)];
    [bottomLock closePath];
    [gray setFill];
    [bottomLock fill];
    
    //// Bezier Drawing
    UIBezierPath *topCadena = [UIBezierPath bezierPath];
    [topCadena moveToPoint: CGPointMake(19.04, 15)];
    [topCadena addCurveToPoint: CGPointMake(18.47, 9.37) controlPoint1: CGPointMake(19.04, 15) controlPoint2: CGPointMake(19.32, 10.78)];
    [topCadena addCurveToPoint: CGPointMake(14.55, 9.37) controlPoint1: CGPointMake(17.63, 7.96) controlPoint2: CGPointMake(15.25, 7.96)];
    [topCadena addCurveToPoint: CGPointMake(13.99, 15) controlPoint1: CGPointMake(13.85, 10.78) controlPoint2: CGPointMake(13.99, 15)];
    [white setStroke];
    topCadena.lineWidth = 2;
    [topCadena stroke];
}

- (void)secureCheckmark {
    [self drawGrayOval];
    [self drawSecureShape];
}

#pragma mark - ACCESSORS -

- (void)setEnable {
    activated = TRUE;
    [self setNeedsDisplay];
}

- (void)setSecure {
    secured = TRUE;
    [self setNeedsDisplay];
}

- (void)setDisable {
    activated = FALSE;
    [self setNeedsDisplay];
}

- (BOOL)isActivated {
    return activated;
}

- (BOOL)isSecured {
    return secured;
}

@end
