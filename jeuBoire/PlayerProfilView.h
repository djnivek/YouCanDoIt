//
//  PlayerProfilView.h
//  jeuBoire
//
//  Created by Kévin MACHADO on 27/02/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerProfilView : UIView <UITextFieldDelegate>

@property (nonatomic, retain) UITextField *playerName;
@property (nonatomic, retain) UISegmentedControl *playerSex;
@property (nonatomic, retain) UILabel *playerNum;

@end
