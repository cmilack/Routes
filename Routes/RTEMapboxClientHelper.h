//
//  RTEMapboxClientHelper.h
//  Routes
//
//  Created by Christopher Milack on 2/18/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const RTEMapboxDirectionsBaseUrl;
extern NSString * const RTEMapboxGeocodeBaseUrl;

@interface RTEMapboxClientHelper : NSObject

+ (void)registerClientToken:(NSString *)token;

+ (NSURLQueryItem *)clientAccessQueryItem;

@end
