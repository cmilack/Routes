//
//  RTESearchResultsViewController.m
//  Routes
//
//  Created by Christopher Milack on 2/18/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTESearchResultsViewController.h"

@interface RTESearchResultsViewController ()

@end

@implementation RTESearchResultsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Disable sprigns & struts
    //
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    UINavigationItem *navItem = self.parentViewController.navigationItem;
    
    
    navItem.leftBarButtonItem = nil;
    navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(didTapDismissButton:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didTapDismissButton:(UIBarButtonItem *)sender
{
    [self.delegate searchResultsViewControllerDidCancel:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Recent";
}

#pragma mark - Search Bar Delegate



@end
