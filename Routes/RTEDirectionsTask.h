//
//  RTEDirectionsTask.h
//  Routes
//
//  Created by Christopher Milack on 2/21/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RTEDirectionsResult;
@class RTEDirectionsTaskParameters;

typedef void(^RTEDirectionsTaskCompletionBlock)(NSURLSessionTask *task, RTEDirectionsResult *result , NSError *error);

@interface RTEDirectionsTask : NSObject

- (NSURLSessionTask *)executeWithParams:(RTEDirectionsTaskParameters *)params
                             completion:(RTEDirectionsTaskCompletionBlock)completion;

@end
