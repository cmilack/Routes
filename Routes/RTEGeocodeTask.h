//
//  RTEGeocodeTask.h
//  Routes
//
//  Created by Christopher Milack on 2/18/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class RTEGeocodeTaskParameters;

typedef void(^RTEGeocodeTaskCompletionBlock)(NSURLSessionTask *task, NSArray *results, NSError *error);
typedef void(^RTEReverseGeocodeTaskCompletionBlock)(NSURLSessionTask *task, id result, NSError *error);

// Execute geocoding tasks using the default mapbox.places dataset
//
// TODO: Extend for other datasets
//
// NOTE: All callbacks will execute on the main (UI) thread
//
@interface RTEGeocodeTask : NSObject

- (NSURLSessionTask *)executeGeocodeWithQuery:(NSString *)query
                                   completion:(RTEGeocodeTaskCompletionBlock)completion;

- (NSURLSessionTask *)executeGeocodeWithQuery:(NSString *)query
                                   parameters:(RTEGeocodeTaskParameters *)params
                                   completion:(RTEGeocodeTaskCompletionBlock)completion;

- (NSURLSessionTask *)executeReverseGeocodeWithLocation:(CLLocationCoordinate2D)location
                                             completion:(RTEReverseGeocodeTaskCompletionBlock)completion;

@end
