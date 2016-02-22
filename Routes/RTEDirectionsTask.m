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
        
    };
    
    NSMutableArray *queryItems = [NSMutableArray array];
    RTECountryCode countryCode;
    if (params) {
        
        countryCode = params.countryCode;
        [queryItems addObjectsFromArray:[params queryItems]];
    }
    
    // Fetch the default security query item
    //
    NSURLQueryItem *securityItem = [MGLAccountManager rte_clientAccessQueryItem];
    if (securityItem) {
        [queryItems addObject:securityItem];
    }
    
    NSString *profile = @"";//
    
    NSString *waypointsText;
//    for (<#initialization#>; <#condition#>; <#increment#>) {
//        <#statements#>
//    }
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.mapbox.com/v5/directions/%@/%@.json",profile, waypointsText];
    
    NSURLComponents *components = [NSURLComponents componentsWithString:urlString];
    components.queryItems = queryItems;
    
    task = [[NSURLSession sharedSession] dataTaskWithURL:components.URL completionHandler:serviceCompletion];
    [task resume];
    
    return task;
}

- (NSString *)stringFromWaypoints
{
    return nil;
}

@end
