//
//  RTEDistanceTask.h
//  Routes
//
//  Created by Christopher Milack on 2/19/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RTEDistanceTaskParameters;
@class RTEDistanceTaskResult;

@interface RTEDistanceTask : NSObject

- (NSURLSessionTask *)executeWithParameters:(RTEDistanceTaskParameters *)params
                                 completion:(void(^)(NSURLSessionTask *task, RTEDistanceTaskResult *result, NSError *error))completion;

@end
