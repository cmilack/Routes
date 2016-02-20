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

// Static methods used to supply RTE MapBox tasks with credentials
//
//
@interface RTEMapboxClientHelper : NSObject

// Register a client token before using any RTE MapBox tasks
//
+ (void)registerClientToken:(NSString *)token;

// A convenience method to retrive a query item for the client access token
//
+ (NSURLQueryItem *)clientAccessQueryItem;

@end
