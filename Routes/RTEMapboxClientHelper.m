//
//  RTEMapboxClientHelper.m
//  Routes
//
//  Created by Christopher Milack on 2/18/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTEMapboxClientHelper.h"

NSString * const RTEMapboxDirectionsBaseUrl = @"";
NSString * const RTEMapboxGeocodeBaseUrl = @"";

static NSString *clientToken;

@implementation RTEMapboxClientHelper

+ (void)registerClientToken:(NSString *)token
{
    if (!clientToken) {
        clientToken = token;
    }
}

+ (NSURLQueryItem *)clientAccessQueryItem
{
    if (!clientToken) {
        return nil;
    }
    
    return [[NSURLQueryItem alloc] initWithName:@"access_token" value:clientToken];
}

@end
