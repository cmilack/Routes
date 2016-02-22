//
//  MGLAccountManager+RTEExtensions.h
//  Routes
//
//  Created by Christopher Milack on 2/21/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <Mapbox/Mapbox.h>

@interface MGLAccountManager (RTEExtensions)

// Convenience method to retrieve a NSURLQueryItem for the mapbox access token
//
+ (NSURLQueryItem *)rte_clientAccessQueryItem;

@end
