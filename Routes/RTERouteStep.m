//
//  RTERouteStep.m
//  Routes
//
//  Created by Christopher Milack on 2/21/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTERouteStep.h"

@implementation RTERouteStep

- (instancetype)initWithJson:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        [self setPropertiesWithJson:json];
    }
    return self;
}

- (void)setPropertiesWithJson:(NSDictionary *)json
{
    _wayName = [json objectForKey:@"way_name"];
    _mode = [json objectForKey:@"mode"];
    _direction = [json objectForKey:@"direction"];
    
    NSNumber *distance = [json objectForKey:@"distance"];
    _distance = distance.doubleValue;
    
    NSNumber *heading = [json objectForKey:@"heading"];
    _heading = heading.doubleValue;
}

@end
