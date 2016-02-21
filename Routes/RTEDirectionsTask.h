//
//  RTEDirectionsTask.h
//  Routes
//
//  Created by Christopher Milack on 2/21/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RTEDirectionsTaskParameters;

typedef void(^RTEDirectionsTaskCompletionBlock)(NSURLSessionTask *task, id result , NSError *error);

@interface RTEDirectionsTask : NSObject

- (NSURLSessionTask *)executeWithWaypoints:(NSArray *)waypoints
                                completion:(RTEDirectionsTaskCompletionBlock)completion;

- (NSURLSessionTask *)executeWithWaypoints:(NSArray *)waypoints
                                    params:(RTEDirectionsTaskParameters *)params
                                completion:(RTEDirectionsTaskCompletionBlock)completion;

@end
