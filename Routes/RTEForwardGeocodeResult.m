//
//  RTEGeocodeResult.m
//  Routes
//
//  Created by Christopher Milack on 2/18/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTEForwardGeocodeResult.h"

@implementation RTEForwardGeocodeResult

- (instancetype)initWithJsonResult:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        [self loadFromJson:json];
    }
    return self;
}

- (void)loadFromJson:(NSDictionary *)json
{
    NSArray *centerCoordinates = [json objectForKey:@"center"];
    NSNumber *latitude = centerCoordinates.firstObject;
    NSNumber *longitude = centerCoordinates.lastObject;
    
    self.center = CLLocationCoordinate2DMake(longitude.doubleValue, latitude.doubleValue);
    
    self.text = [json objectForKey:@"text"];
    self.placeName = [json objectForKey:@"place_name"];
    self.featureId = [json objectForKey:@"id"];
    
    NSArray *bboxCoordinates = [json objectForKey:@"bbox"];
    double swLon = [[bboxCoordinates objectAtIndex:0] doubleValue];
    double swLat = [[bboxCoordinates objectAtIndex:1] doubleValue];
    double neLon = [[bboxCoordinates objectAtIndex:2] doubleValue];
    double neLat = [[bboxCoordinates objectAtIndex:3] doubleValue];
    
    CLLocationCoordinate2D sw = CLLocationCoordinate2DMake(swLat,swLon);
    CLLocationCoordinate2D ne = CLLocationCoordinate2DMake(neLat,neLon);
    
    self.boundingBox = MGLCoordinateBoundsMake(sw,ne);

}

#pragma mark - MGLAnnotation

- (CLLocationCoordinate2D)coordinate
{
    return self.center;
}

- (NSString *)title
{
    return self.text;
}

- (NSString *)subtitle
{
    return @"";
}

@end
