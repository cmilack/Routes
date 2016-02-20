//
//  RTEQueryItemProvider.h
//  Routes
//
//  Created by Christopher Milack on 2/18/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <Foundation/Foundation.h>

// An interface for parameter objects used with API tasks. Parameters classes
// implement this protocol to provide clients with the query parameters for
// their corresponding service request
//
@protocol RTEQueryItemProvider <NSObject>

// Array of NSURLQueryItem
//
- (NSArray  *)queryItems;

@end
