//
//  QRLibrary.m
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 23/03/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "QRLibrary.h"
#import "QuestionReponse.h"

@implementation QRLibrary

- (id)init
{
    self = [super init];
    if (self) {
        questionsListe = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)addQR:(QuestionReponse *)qr {
    if (!questionsListe)
        questionsListe = [[NSMutableArray alloc]init];
    
    [questionsListe addObject:qr];
}

- (int)nbOfQuestion {
    return [questionsListe count];
}

- (BOOL)containsQuestions {
    return ([questionsListe count] > 0);
}

- (QuestionReponse *)getQrAtIndex:(int)i {
    return [questionsListe objectAtIndex:i];
}

- (void)saveToLocal {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"questions.txt"];
    NSLog(@"saveToLocal %@ : questionsListe : %@", appFile, questionsListe);
    BOOL test = [NSKeyedArchiver archiveRootObject:questionsListe toFile:appFile];
    NSLog(@"Voila -> %d", test);
}

- (void)loadFromLocal {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"questions.txt"];
    questionsListe = [NSKeyedUnarchiver unarchiveObjectWithFile:appFile];
    NSLog(@"loadFromLocal : %@", questionsListe);
}

@end
