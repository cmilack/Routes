//
//  RTEDirectionsTask.m
//  Routes
//
//  Created by Christopher Milack on 2/21/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTEDirectionsTask.h"
#import "RTEDirectionsTaskParameters.h"
#import "RTEDirectionsResult.h"
#import "MGLAccountManager+RTEExtensions.h"
#import "RTEDirectionsRequestFactory.h"

@implementation RTEDirectionsTask

- (NSURLSessionTask *)executeWithParams:(RTEDirectionsTaskParameters *)params
                             completion:(RTEDirectionsTaskCompletionBlock)completion

{
    __block NSURLSessionDataTask *task;
    
    void (^serviceCompletion)(NSData *, NSURLResponse *, NSError *);
    serviceCompletion = ^(NSData *data, NSURLResponse * response, NSError * error){
        
        if (error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                completion(task, nil,error);
            });
            return;
        }
        
        NSError *jsonError;
        id jsonResult = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (!jsonResult) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                completion(task, nil,jsonError);
            });
            
            return;
        }
        
        RTEDirectionsResult *result = [[RTEDirectionsResult alloc] initWithJson:jsonResult];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            completion(task, result, nil);
        });
    };

    NSURLRequest *request = [RTEDirectionsRequestFactory urlRequestWithParameters:params];
    task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:serviceCompletion];
    [task resume];
    
    return task;
}

@end
