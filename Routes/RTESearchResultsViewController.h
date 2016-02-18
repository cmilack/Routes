//
//  RTESearchResultsViewController.h
//  Routes
//
//  Created by Christopher Milack on 2/18/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTESearchResultsViewController;

@protocol RTESearchResultViewControllerDelegate <NSObject>

@required
- (void)searchResultsViewControllerDidCancel:(RTESearchResultsViewController *)viewController;

@end

@interface RTESearchResultsViewController : UITableViewController<UISearchBarDelegate>

@property (nonatomic,weak) id<RTESearchResultViewControllerDelegate> delegate;

@end
