//
//  Utils.m
//  YouCanDoIt
//
//  Created by Kévin MACHADO on 31/03/2014.
//  Copyright (c) 2014 Kévin MACHADO. All rights reserved.
//

#import "Utils.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "OpenUDID.h"

@implementation Utils

+ (void)addNewSession {
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [OpenUDID value], @"open_udid",
                            @"1", @"operating_system", // 1 : iPhone -- 2 : Android
                            nil];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[Const serverURL:@"onstart.php"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Params : %@ || Operation : %@", params, operation);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
