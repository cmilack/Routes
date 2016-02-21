//
//  RTEDistanceTask.h
//  Routes
//
//  Created by Christopher Milack on 2/19/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RTEDistanceTaskParameters;
@class RTEDistanceResult;

typedef void(^RTEDistanceTaskCompletionBlock)(NSURLSessionTask *task, RTEDistanceResult *result, NSError *error);

@interface RTEDistanceTask : NSObject

- (NSURLSessionTask *)executeWithParameters:(RTEDistanceTaskParameters *)params
                                 completion:(RTEDistanceTaskCompletionBlock)completion;

@end
