//
//  GageField.m
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 17/03/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "GageFields.h"

@implementation GageFields

- (id)initWithGageField:(UILabel *)_textView andAcceptBtn:(UIButton *)_accept refuseBtn:(UIButton *)_refuse
{
    self = [super init];
    if (self) {
        gageField = _textView;
        acceptButton = _accept;
        refuseButton = _refuse;
    }
    return self;
}

- (void)setText:(NSString *)text {
    [gageField setText:text];
}

- (void)hiddeGageLayout:(BOOL)hiddeIt {
    [acceptButton setHidden:hiddeIt];
    [refuseButton setHidden:hiddeIt];
    [gageField setHidden:hiddeIt];
}

@end
