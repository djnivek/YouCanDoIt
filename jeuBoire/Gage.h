//
//  Gage.h
//  jeuBoire
//
//  Created by Kévin MACHADO on 19/01/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gage : NSObject
{
    int level;
    NSString *description;
}

- (id)initWithLevel:(int)_level desc:(NSString *)d;
- (NSString *)getDescription;

@end
