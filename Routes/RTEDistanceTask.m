//
//  RTEDistanceTask.m
//  Routes
//
//  Created by Christopher Milack on 2/19/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTEDistanceTask.h"
#import "RTEDistanceTaskParameters.h"
#import "MGLAccountManager+RTEExtensions.h"
#import "RTEEnumerations.h"
#import "RTEDistanceRequestFactory.h"

@implementation RTEDistanceTask

- (NSURLSessionTask *)executeWithParameters:(RTEDistanceTaskParameters *)params
                                 completion:(void(^)(NSURLSessionTask *task, RTEDistanceResult *result, NSError *error))completion
{
    __block NSURLSessionDataTask *task;
    
    void (^serviceCompletion)(NSData *, NSURLResponse *, NSError *);
    serviceCompletion = ^(NSData *data, NSURLResponse * response, NSError * error){
        
        if (error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                completion(task, nil, error);
            });
            return;
        }
        
        NSError *jsonError;
        id jsonResult = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (!jsonResult) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                completion(task, nil, jsonError);
            });
            
            return;
        }
        

        // We have valid json - convert that into geocode result objects
        //
        dispatch_async(dispatch_get_main_queue(), ^{
            
            completion(task, nil, nil);
        });
    };
    
    NSURLRequest *request = [RTEDistanceRequestFactory urlRequestWithParameters:params];
    task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:serviceCompletion];
    [task resume];
    
    return task;
}

@end
