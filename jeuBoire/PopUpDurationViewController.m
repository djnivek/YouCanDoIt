//
//  PopViewController.m
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 25/03/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "PopUpDurationViewController.h"

//#define kHeightBar 44

@interface PopUpDurationViewController ()

@end

@implementation PopUpDurationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // use toolbar as background because its pretty in iOS7
    UIToolbar *toolbarBackground = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 44, 200, 106)];
    [self.view addSubview:toolbarBackground];
    [self.view sendSubviewToBack:toolbarBackground];
    
    //CGFloat height = self.view.frame.size.height;
    //CGFloat width = self.view.frame.size.width;
    
    /*progessView = [[UIProgressView alloc] init];
    [progessView setCenter:CGPointMake(width/2, kHeightBar+(height-kHeightBar)/2)];*/
    
    //progress = [[EVCircularProgressView alloc] initWithFrame:CGRectMake(0, 0, width/2, height/2)];
    //[progress setCenter:CGPointMake(width/2, kHeightBar+(height-kHeightBar)/2)];
    // set size
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setPopupTitle:(NSString *)title {
    navigationbar.topItem.title = title;
}

- (void)setDuration:(CGFloat)_duration {
    duration = _duration;
}

- (void)startIndeterminate {
    [activityIndicator startAnimating];
}

- (void)stopIndeterminate {
    [activityIndicator stopAnimating];
}

- (void)stopIndeterminateWithInvocation:(NSInvocation *)invocation {
    [activityIndicator stopAnimating];
    [invocation invoke];
}

- (void)startWithDuration:(CGFloat)_duration completion:(void (^)(void))completion {
    [self setDuration:_duration];
    
    [self startIndeterminate];
    
    [self performSelector:@selector(stopIndeterminateWithInvocation:) withObject:completion afterDelay:duration];
}

/*
- (void)updateProgress {
    
    [progessView setProgress:[progessView progress]+0.01 animated:YES];
}
*/

@end
