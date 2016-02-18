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

// Bottom Bar Outlets
//
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *bottomLayoutConstraint;
@property (nonatomic,weak) IBOutlet UIToolbar *bottomToolbar;
@property (nonatomic,weak) IBOutlet UIBarButtonItem *gpsButton;

// A flag to ignore user interaction from tapping. Our tap gesture recognizer will
// wire up a delayed selector giving the mapView:didSelectAnnotation: an opportunit
// to set this flag to YES, indicating that we should ignore the normal tap interaction
//
@property (nonatomic) BOOL ignoreTap;

@end

@implementation RTEMapViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        CLLocationManager *lm = [[CLLocationManager alloc] init];
        [lm requestAlwaysAuthorization];
    }
    return self;
}

- (void)dealloc
{
    [self.mapView removeObserver:self forKeyPath:NSStringFromSelector(@selector(userTrackingMode))];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
  
    UITapGestureRecognizer *gr =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapMap:)];
    [self.mapView addGestureRecognizer:gr];

    // set the map's center coordinates and zoom level
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(40.7326808, -73.9843407)
                       zoomLevel:12
                        animated:NO];
    
    [self.mapView showsUserLocation];
    
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
    
    // Set up KVO properties
    //
    [self.mapView addObserver:self
                   forKeyPath:NSStringFromSelector(@selector(userTrackingMode))
                      options:0
                      context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(userTrackingMode))]) {
        
        [self updateGPSButtonStyle];
    }
}

#pragma mark - UI Actions

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

- (IBAction)didTapGPSButton:(UIBarButtonItem *)sender
{
    if (!self.mapView.isUserLocationVisible) {
        self.mapView.showsUserLocation = YES;
    }
    
    switch (self.mapView.userTrackingMode) {
        case MGLUserTrackingModeNone:
            self.mapView.userTrackingMode = MGLUserTrackingModeFollow;
            break;
        case MGLUserTrackingModeFollow:
            self.mapView.userTrackingMode = MGLUserTrackingModeFollowWithCourse;
            break;
        case MGLUserTrackingModeFollowWithCourse:
            self.mapView.showsUserLocation = NO;
            self.mapView.userTrackingMode = MGLUserTrackingModeNone;
            break;
        default:
            break;
    }
}

- (void)updateGPSButtonStyle
{
    if (!self.mapView.showsUserLocation) {
        self.gpsButton.tintColor = [UIColor whiteColor];
        self.gpsButton.image = [UIImage imageNamed:@"GPS_Off"];
        return;
    }

    self.gpsButton.tintColor = [UIColor blueColor];
    switch (self.mapView.userTrackingMode) {
        case MGLUserTrackingModeNone:
            self.gpsButton.image = [UIImage imageNamed:@"GPS_Off"];
            break;
        case MGLUserTrackingModeFollow:
            self.gpsButton.image = [UIImage imageNamed:@"GPS_On"];
            break;
        case MGLUserTrackingModeFollowWithCourse:
            self.gpsButton.image = [UIImage imageNamed:@"Navigation"];
            break;
        default:
            break;
    }
}

#pragma mark - Toolbar Toggles

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
