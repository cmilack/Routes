//
//  RTEMapViewController.m
//  Routes
//
//  Created by Christopher Milack on 2/17/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTEMapViewController.h"
#import <Mapbox/Mapbox.h>
#import "UINavigationController+RTEExtensions.h"

@interface RTEMapViewController ()<MGLMapViewDelegate>

@property (nonatomic,weak) IBOutlet MGLMapView *mapView;

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
    
    self.navigationItem.titleView = [[UISearchBar alloc] init];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                          target:nil
                                                                                          action:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                           target:nil
                                                                                           action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    double newBottomConstraintConstant;
    if (self.bottomLayoutConstraint.constant < 0) {
        newBottomConstraintConstant = 0;
    } else {
        newBottomConstraintConstant = - CGRectGetHeight(self.bottomToolbar.frame);
    }
    
    [self.bottomToolbar layoutIfNeeded];
    [UIView animateWithDuration:.25 animations:^{
       
        self.bottomLayoutConstraint.constant = newBottomConstraintConstant;
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

@end
