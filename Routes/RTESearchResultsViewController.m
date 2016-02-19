//
//  RTESearchResultsViewController.m
//  Routes
//
//  Created by Christopher Milack on 2/18/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTESearchResultsViewController.h"
#import "RTEGeocodeTask.h"
#import "RTEGeocodeResult.h"

NSString *const kRTESearchResultsTableCellId = @"defaultCell";

@interface RTESearchResultsViewController ()
{
    RTEGeocodeTask *_geocodeTask;
}

@property (nonatomic,weak) UISearchBar *searchBar;

@property (nonatomic,readonly) RTEGeocodeTask *geocodeTask;

@property (nonatomic) NSArray *lastResult;

@end

@implementation RTESearchResultsViewController

- (instancetype)initWithSearchBar:(UISearchBar *)searchBar
{
    self = [super init];
    if (self) {
        _searchBar = searchBar;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.searchBar.delegate = self;
    
    // Disable sprigns & struts
    //
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    UINavigationItem *navItem = self.parentViewController.navigationItem;
    
    
    navItem.leftBarButtonItem = nil;
    navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                               target:self
                                                                               action:@selector(didTapDismissButton:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)didTapDismissButton:(UIBarButtonItem *)sender
{
    [self.delegate searchResultsViewControllerDidCancel:self];
}

- (RTEGeocodeTask *)geocodeTask
{
    if (!_geocodeTask) {
        _geocodeTask = [[RTEGeocodeTask alloc] init];
    }
    
    return _geocodeTask;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.lastResult.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.lastResult.count ? @"Results" : @"Recent";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RTEGeocodeResult *result = [self.lastResult objectAtIndex:indexPath.row];
    
    // TODO: Setup custom cell reuse
    //
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.textLabel.text = result.placeName;
    cell.detailTextLabel.text = result.text;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RTEGeocodeResult *result = [self.lastResult objectAtIndex:indexPath.row];
    [self.delegate searchResultsViewController:self didSelectResult:result];
}

#pragma mark - Search Bar Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self performSelector:@selector(executeSearchWithText:) withObject:searchText afterDelay:.75];
}

- (void)executeSearchWithText:(NSString *)searchText
{
    if ([searchText isEqualToString:self.searchBar.text]) {
        
        [self.geocodeTask executeWithQuery:searchText completion:^(NSURLSessionTask *task, NSArray *results, NSError *error) {
            
            NSLog(@"task complete");
            self.lastResult = results;
            [self.tableView reloadData];
        }];
    }
}

@end
