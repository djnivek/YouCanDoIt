//
//  AnswerFields.m
//  jeuBoire
//
//  Created by Kévin MACHADO on 07/03/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "QRFields.h"
#import "QuestionReponse.h"
#import "QRSController.h"

@implementation QRFields

- (id)initWithFieldA:(UILabel *)_tviewA fieldB:(UILabel *)_tviewB fieldC:(UILabel *)_tviewC fieldD:(UILabel *)_tviewD
{
    self = [super init];
    if (self) {
        arrayTxtViewAnswers = [[NSMutableArray alloc] init];
        [arrayTxtViewAnswers addObject:_tviewA];
        [arrayTxtViewAnswers addObject:_tviewB];
        [arrayTxtViewAnswers addObject:_tviewC];
        [arrayTxtViewAnswers addObject:_tviewD];
    }
    return self;
}

- (void)setBtnA:(UIButton *)_btnA btnB:(UIButton *)_btnB btnC:(UIButton *)_btnC btnD:(UIButton *)_btnD
{
    btnA = _btnA;
    [btnA setTag:1];
    
    btnB = _btnB;
    [btnB setTag:2];
    
    btnC = _btnC;
    [btnC setTag:3];
    
    btnD = _btnD;
    [btnD setTag:4];
}

- (void)setButtonTarget {
    [btnA addTarget:controller action:@selector(didRespondByClickingOn:) forControlEvents:UIControlEventTouchDown];
    [btnB addTarget:controller action:@selector(didRespondByClickingOn:) forControlEvents:UIControlEventTouchDown];
    [btnC addTarget:controller action:@selector(didRespondByClickingOn:) forControlEvents:UIControlEventTouchDown];
    [btnD addTarget:controller action:@selector(didRespondByClickingOn:) forControlEvents:UIControlEventTouchDown];
}

- (void)setController:(QRSController *)_controller {
    controller = _controller;
    [self setButtonTarget];
}

- (void)setQuestionField:(UILabel *)_qField {
    question = _qField;
}

- (void)setQuestionReponse:(QuestionReponse *)qr {
    [question setText:[qr getQuestion]];
    for (int i = 0; i < [[qr getAnswers] count]; i++) {
        UITextView *txtV = [arrayTxtViewAnswers objectAtIndex:i];
        [txtV setText:[[qr getAnswers] objectAtIndex:i]];
    }
}

@end