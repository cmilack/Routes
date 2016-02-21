//
//  RTEDirectionsTask.m
//  Routes
//
//  Created by Christopher Milack on 2/21/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTEDirectionsTask.h"

@implementation RTEDirectionsTask

- (NSURLSessionTask *)executeWithWaypoints:(NSArray *)waypoints
                                completion:(RTEDirectionsTaskCompletionBlock)completion
{
    return [self executeWithWaypoints:waypoints params:nil completion:completion];
}

- (NSURLSessionTask *)executeWithWaypoints:(NSArray *)waypoints
                                    params:(RTEDirectionsTaskParameters *)params
                                completion:(RTEDirectionsTaskCompletionBlock)completion
{
    NSAssert(NO, @"Not yet implemented");
    return nil;
}

@end
