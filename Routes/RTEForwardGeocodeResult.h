//
//  RTEGeocodeResult.h
//  Routes
//
//  Created by Christopher Milack on 2/18/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <Mapbox/Mapbox.h>

@class MGLPolygon;
@class MGLShape;

// A model object representing a MapBox Forward Geocode Results
// TODO: Handle additional fields - Properties, type, place name,etc.
//
@interface RTEForwardGeocodeResult : NSObject

@property (nonatomic) CLLocationCoordinate2D center;
@property (nonatomic) MGLCoordinateBounds boundingBox;

@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *placeName;
@property (nonatomic,copy) NSString *featureId;

// TODO: @property (nonatomic) MGLShape *geometry;

- (instancetype)initWithDictionary:(NSDictionary *)json;

@end
