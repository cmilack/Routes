//
//  RTEDistanceRequestFactory.h
//  Routes
//
//  Created by Christopher Milack on 2/21/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RTEDistanceTaskParameters;

@interface RTEDistanceRequestFactory : NSObject

+ (NSURLRequest *)urlRequestWithParameters:(RTEDistanceTaskParameters *)params;

@end
