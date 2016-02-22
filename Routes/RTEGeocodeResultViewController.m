//
//  RTEGeocodeResultViewController.m
//  Routes
//
//  Created by Christopher Milack on 2/20/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTEGeocodeResultViewController.h"
#import <Mapbox/Mapbox.h>
#import "RTEGeocodeResult.h"
#import <ContactsUI/ContactsUI.h>

@implementation RTEGeocodeResultViewController

- (instancetype)initWithGeocodeResult:(RTEGeocodeResult *)result
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        _result = result;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableHeaderView = [self tableHeaderView];
}

- (UIView *)tableHeaderView
{
    MGLMapView *mapView = [[MGLMapView alloc] initWithFrame:CGRectMake(0, 0, 100, 180)];
    [mapView setCenterCoordinate:self.result.center zoomLevel:12 animated:NO];
    mapView.userInteractionEnabled = NO;
    
    return mapView;
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return  [self tableView:tableView cellForDirectionsSectionAtIndexPath:indexPath];
    } else if (indexPath.section == 1){
        return  [self tableView:tableView cellForContactsSectionAtIndexPath:indexPath];
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForDirectionsSectionAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.textColor = [UIColor blueColor];
    
    if (indexPath.row == 0) {
        
        // Directions
        //
        cell.textLabel.text = @"Directions";
        
    } else if (indexPath.row == 1) {
        
        // Address
        //
        cell.textLabel.text = @"Address";
    }
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForContactsSectionAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.textColor = [UIColor blueColor];
    
    if (indexPath.row == 0) {
        
        // New Contact
        //
        cell.textLabel.text = @"Create New Contact";
        
    } else if (indexPath.row == 1) {
        
        // Existing Contact
        //
        cell.textLabel.text = @"Add to Existing Contact";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 ) {
        
        if (indexPath.row == 0) {
            
            [self.delegate geocodeResultViewControllerDidSelectDirectionsOption:self];
        }
        
    } else if (indexPath.section == 1){

    }
}

@end
