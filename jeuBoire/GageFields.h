//
//  GageField.h
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 17/03/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GageFields : NSObject
{
    UILabel *gageField;
    
    UIButton *acceptButton;
    UIButton *refuseButton;
}

- (id)initWithGageField:(UILabel *)_textView andAcceptBtn:(UIButton *)_accept refuseBtn:(UIButton *)_refuse;

- (void)setText:(NSString *)text;

- (void)hiddeGageLayout:(BOOL)hiddeIt;

@end
