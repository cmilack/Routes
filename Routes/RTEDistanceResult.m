//
//  RTEDistanceTaskResult.m
//  Routes
//
//  Created by Christopher Milack on 2/19/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTEDistanceResult.h"

@interface RTEDistanceResult()

// An array of arrays - This is a matrix of distances from each input stop
// to every other input stop. Keeping this internal and expposing only some basic
// accessor methods publicly (simpler API).
//
@property (nonatomic) NSMutableArray *distances;

@end

@implementation RTEDistanceResult

- (instancetype)initWithJsonResult:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        [self loadFromJson:json];
    }
    return self;
}

//{
//    "code": "Ok",
//    "durations": [
//                  [ 0,    2910, null ],
//                  [ 2903, 0,    5839 ],
//                  [ 4695, 5745, 0    ]
//                  ]
//}
- (void)loadFromJson:(NSDictionary *)json
{
    self.distances = [NSMutableArray array];
    
    NSArray *durations = [json objectForKey:@"durations"];
    for (int i = 0; i < durations.count; i++){
    
        NSMutableArray *stopDistances = [NSMutableArray array];
        [self.distances addObject:stopDistances];
        
        NSArray *duration = [durations objectAtIndex:i];
        for (int j = 0; j < durations.count; j++) {
            
            id result = [duration objectAtIndex:j];
            [stopDistances addObject:result];
        }
    }
    
    NSLog(@"result %@", self.distances.description);
}

- (NSInteger)distanceFromStopAtIndex:(NSUInteger)start toIndex:(NSUInteger)end
{
    if (start >= self.distances.count) {
        return RTEResultNotFound;
    }
    
    NSArray *resultsFromStart = [self.distances objectAtIndex:start];
    
    if (resultsFromStart.count >= end) {
        return RTEResultNotFound;
    }
    
    NSNumber *distance = [resultsFromStart objectAtIndex:end];
    return [distance integerValue];    
}

@end
