//
//  CheckmarkView.h
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 10/04/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckmarkView : UIView
{
    //// Color Declarations
    UIColor *white;
    UIColor *blue;
    UIColor *invisible;
    
    UIBezierPath *ovalPath;
    UIBezierPath *bezierPath;
}

- (void)setEnable;
- (void)setDisable;
- (void)setSecure;

@end
