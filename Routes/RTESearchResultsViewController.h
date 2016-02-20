//
//  RTESearchResultsViewController.h
//  Routes
//
//  Created by Christopher Milack on 2/18/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTEForwardGeocodeResult;
@class RTESearchResultsViewController;

@protocol RTESearchResultViewControllerDelegate <NSObject>

@required
- (void)searchResultsViewControllerDidCancel:(RTESearchResultsViewController *)viewController;

- (void)searchResultsViewController:(RTESearchResultsViewController *)viewController
                    didSelectResult:(RTEForwardGeocodeResult *)result;

@end

@interface RTESearchResultsViewController : UITableViewController<UISearchBarDelegate>

- (instancetype)initWithSearchBar:(UISearchBar *)searchBar;

@property (nonatomic,weak) id<RTESearchResultViewControllerDelegate> delegate;

@end
