//
//  RTEGeocodeTask.h
//  Routes
//
//  Created by Christopher Milack on 2/18/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RTEForwardGeocodeParameters;

// Execute geocoding tasks using the default mapbox.places dataset
//
// TODO: Extend for other datasets
//
// NOTE: All callbacks will execute on the main (UI) thread
//
@interface RTEGeocodeTask : NSObject

- (NSURLSessionTask *)executeWithQuery:(NSString *)query
                            completion:(void(^)(NSURLSessionTask *task,NSArray *results, NSError *error))completion;

- (NSURLSessionTask *)executeWithQuery:(NSString *)query
                            parameters:(RTEForwardGeocodeParameters *)params
                            completion:(void(^)(NSURLSessionTask *task, NSArray *results, NSError *error))completion;

@end
