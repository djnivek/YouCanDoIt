//
//  AnswerFields.h
//  jeuBoire
//
//  Created by Kévin MACHADO on 07/03/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QuestionReponse;
@class QRSController;

@interface QRFields : NSObject
{
    //  Text View Fields
    NSMutableArray *arrayTxtViewAnswers;
    
    //  Text View Question Field
    UILabel *question;
    
    //  Button
    UIButton *btnA;
    UIButton *btnB;
    UIButton *btnC;
    UIButton *btnD;
    
    NSArray *questions;
    
    QRSController *controller;
}

- (id)initWithFieldA:(UILabel *)_tviewA fieldB:(UILabel *)_tviewB fieldC:(UILabel *)_tviewC fieldD:(UILabel *)_tviewD;
- (void)setBtnA:(UIButton *)_btnA btnB:(UIButton *)_btnB btnC:(UIButton *)_btnC btnD:(UIButton *)_btnD;
- (void)setController:(QRSController *)_controller;
- (void)setQuestionReponse:(QuestionReponse *)qr;
- (void)setQuestionField:(UILabel *)_qField;

@end
