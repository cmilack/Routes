//
//  MGLAccountManager+RTEExtensions.m
//  Routes
//
//  Created by Christopher Milack on 2/21/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "MGLAccountManager+RTEExtensions.h"

@implementation MGLAccountManager (RTEExtensions)

+ (NSURLQueryItem *)rte_clientAccessQueryItem
{
    NSString *accessToken = [MGLAccountManager accessToken];
    NSAssert(accessToken.length > 0, @"The mapbox client access token must be set before performing requests");
    
    return [[NSURLQueryItem alloc] initWithName:@"access_token" value:accessToken];
}

@end
