//
//  RTEDistanceTask.m
//  Routes
//
//  Created by Christopher Milack on 2/19/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTEDistanceTask.h"
#import "RTEMapboxClientHelper.h"
#import "RTEDistanceTaskParameters.h"

@implementation RTEDistanceTask

- (NSString *)profileNameFromProfile:(RTEDistanceTaskProfile)profile
{
    switch (profile) {
        case RTEDistanceTaskProfileDriving:
            return @"driving";
        case RTEDistanceTaskProfileCycling:
            return @"cycling";
        case RTEDistanceTaskProfileWalking:
            return @"walking";
        default:
            return nil;
    }
}

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
    
    NSString *profile = [self profileNameFromProfile:params.profile];
    NSString *urlString = [NSString stringWithFormat:@"https://api.mapbox.com/distances/v1/mapbox/%@",profile];
    
    NSURLComponents *components = [NSURLComponents componentsWithString:urlString];
    components.queryItems = @[[RTEMapboxClientHelper clientAccessQueryItem]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:components.URL
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
    
    NSError *error;
    NSData *postData = [self requestDataFromParams:params error:&error];
    
    if (error) {

        // If we error out trying to get json we still need to fire the completion block
        //
        dispatch_async(dispatch_get_main_queue(), ^{
            
            completion(nil, nil, error);
        });
        
        return nil;
    }
    
    [request setHTTPBody:postData];
    
    task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:serviceCompletion];
    [task resume];
    
    return task;
}

- (NSData *)requestDataFromParams:(RTEDistanceTaskParameters *)params error:(NSError **)error
{
    NSUInteger numOfStops = [params numberOfPoints];
    NSMutableArray *stops = [NSMutableArray array];
    
    for (int i= 0; i< numOfStops; i++){
        
        CLLocationCoordinate2D point = [params pointAtIndex:i];
        NSArray *coordinate = @[@(point.latitude),@(point.longitude)];
        [stops addObject:coordinate];
    }
    
    NSDictionary *coordinates = @{ @"coordinates" : stops };
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:coordinates options:0 error:error];

    return postData;
}

@end
