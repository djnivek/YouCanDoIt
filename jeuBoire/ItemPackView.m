//
//  ItemQuestionView.m
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 08/04/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "ItemPackView.h"
#import "ItemPack.h"
#import "CheckmarkView.h"
#import "ViewControllerSelectPlayers.h"

#define COEF_DIV 1.3

@implementation ItemPackView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        label = [[UILabel alloc] init];
        item = [[ItemPack alloc] init];
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
    if ([item isSecured])
        [checkmarkView setSecure];
    CGFloat x = (self.frame.size.width/2)+((self.frame.size.width/COEF_DIV)/2)-20;
    CGFloat y = (self.frame.size.height/2)-((self.frame.size.height/COEF_DIV)/2)+20;
    [checkmarkView setCenter:CGPointMake(x, y)];
    [self addSubview:checkmarkView];
}

#pragma mark - EVENT -

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![item isSecured])
        [self setEnable:![checkmarkView isActivated]];
    else
        [self itemUnPurchased];
}

- (void)itemUnPurchased {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Petit problème"
                                                    message:@"L'élément que vous souhaitez utiliser n'est pas débloqué, voulez vous obtenir plus d'information sur l'objet ?"
                                                   delegate:mainDelegate
                                          cancelButtonTitle:@"Non"
                                          otherButtonTitles:@"Plus d'informations", nil];
    [alert show];
}

#pragma mark - ACCESSORS -

- (void)setMainDelegate:(ViewControllerSelectPlayers*)delegate {
    mainDelegate = delegate;
}

- (void)setEnable:(BOOL)enable {
    if (!checkmarkView)
        [self addCheckMark];
    
    if (enable)
        [checkmarkView setEnable];
    else
        [checkmarkView setDisable];
}

- (void)setItem:(ItemPack *)pG {
    item = pG;
    [label setText:[item title]];
}

- (ItemPack *)item {
    return item;
}

- (BOOL)isSelected {
    return [checkmarkView isActivated];
}

- (BOOL)isSecured {
    return [checkmarkView isSecured];
}

@end