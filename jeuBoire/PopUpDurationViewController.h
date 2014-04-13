//
//  PopViewController.h
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 25/03/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopUpDurationViewController : UIViewController
{
    IBOutlet UINavigationBar *navigationbar;
    //EVCircularProgressView *progress;
    
    //UIProgressView *progessView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    CGFloat duration;
    NSTimer *updateTimer;
}

- (void)setPopupTitle:(NSString *)title;
- (void)startIndeterminate;
- (void)stopIndeterminate;
- (void)startWithDuration:(CGFloat)_duration completion:(void (^)(void))completion;

@end
