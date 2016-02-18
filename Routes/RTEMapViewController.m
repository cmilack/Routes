//
//  RTEMapViewController.m
//  Routes
//
//  Created by Christopher Milack on 2/17/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTEMapViewController.h"
#import <Mapbox/Mapbox.h>

#import "RTESearchResultsViewController.h"

#import "UINavigationController+RTEExtensions.h"
#import "UIView+RTEAutolayout.h"

@interface RTEMapViewController ()<MGLMapViewDelegate, UISearchBarDelegate,RTESearchResultViewControllerDelegate>

@property (nonatomic,weak) IBOutlet MGLMapView *mapView;

// Top Navigation Bar
//
@property (nonatomic,weak) UISearchBar *searchBar;

// Bottom Toolbar
//
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *bottomLayoutConstraint;
@property (nonatomic,weak) IBOutlet UIToolbar *bottomToolbar;

// A flag to ignore user interaction from tapping. Our tap gesture recognizer will
// wire up a delayed selector giving the mapView:didSelectAnnotation: an opportunit
// to set this flag to YES, indicating that we should ignore the normal tap interaction
//
@property (nonatomic) BOOL ignoreTap;

@end

@implementation RTEMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    UITapGestureRecognizer *gr =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapMap:)];
    [self.mapView addGestureRecognizer:gr];

    // set the map's center coordinates and zoom level
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(40.7326808, -73.9843407)
                       zoomLevel:12
                        animated:NO];
    
    // Set up the rest of our UI
    // Search bar
    // navigation items
    //
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder = @"Search for place or address";
    searchBar.delegate = self;
    
    self.searchBar = searchBar;
    self.navigationItem.titleView = searchBar;
    
    [self addDefaultSideNavigationItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addDefaultSideNavigationItems
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                          target:nil
                                                                                          action:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                           target:nil
                                                                                           action:nil];
}

- (void)didTapMap:(id)sender
{
    // We dispatch a call asynchronously to the main thread. This allows the current
    // run loop to finish doing it's thing before updating this navigation bar.
    // This allows our annotation method to catch the tap and handle it which
    // will also set the ignore flag
    //
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self toggleNavigationBars];
        
        // Reset our ignore flag
        //
        self.ignoreTap = NO;
    });
}

- (void)toggleNavigationBars
{
    if (!self.ignoreTap) {
        
        [self.navigationController rte_toggleNavigationBarVisibility];
        [self toggleBottomBar];
    }
}

- (void)toggleBottomBar
{
    if (self.bottomLayoutConstraint.constant < 0) {
        [self showBottomBar];
    } else {
        [self hideBottomBar];
    }
}

- (void)showBottomBar
{
    // TODO: Check if already visible
    //
    
    [self.bottomToolbar layoutIfNeeded];
    [UIView animateWithDuration:.25 animations:^{
        
        self.bottomLayoutConstraint.constant = 0;
        [self.bottomToolbar layoutIfNeeded];
    }];
}

- (void)hideBottomBar
{
    // TODO: Check if already hidden
    //
    
    [self.bottomToolbar layoutIfNeeded];
    [UIView animateWithDuration:.25 animations:^{
        
        self.bottomLayoutConstraint.constant = - CGRectGetHeight(self.bottomToolbar.frame);
        [self.bottomToolbar layoutIfNeeded];
    }];
}

#pragma mark - MGLMapViewDelegate

- (void)mapView:(MGLMapView *)mapView didSelectAnnotation:(id <MGLAnnotation>)annotation
{
    // Set flag to ignore default user tap behavior
    //
    self.ignoreTap = YES;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self hideBottomBar];
    
    // Add the search result view controller on top of our map content
    //
    RTESearchResultsViewController *searchResultsVC = [[RTESearchResultsViewController alloc] init];
    searchResultsVC.delegate = self;
    [self addChildViewController:searchResultsVC];
    
    // Set up fade-in animation for new vc (to match apples maps app)
    //
    searchResultsVC.view.alpha = 0.0;
    [self.view addSubview:searchResultsVC.view];
    [UIView animateWithDuration:.25 animations:^{
        
        searchResultsVC.view.alpha = 1.0;
    }];
    
    
    [searchResultsVC.view rte_fitInSuperViewFromTop:self.topLayoutGuide.length left:0 right:0 bottom:0];
}

#pragma mark - RTESearchResultsViewControllerDelegate

- (void)searchResultsViewControllerDidCancel:(RTESearchResultsViewController *)viewController
{
    [self.searchBar resignFirstResponder];
    
    // Animate the search results view out and then remove it completely
    // We animate the bottom bar in at the same time
    //
    [self showBottomBar];
    [UIView animateWithDuration:.25 animations:^{
        viewController.view.alpha = 0.0;
    } completion:^(BOOL finished) {

        [viewController.view removeFromSuperview];
        [viewController removeFromParentViewController];
    }];
    
    // Reestablish ownership of the search bar via it's delegate
    //
    self.searchBar.delegate = self;
    
    // Update left and right bar button items
    //
    [self addDefaultSideNavigationItems];
}

@end
