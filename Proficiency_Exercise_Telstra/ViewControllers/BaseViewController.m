//
//  BaseViewController.m
//  Proficiency_Exercise_Telstra
//
//  Created by Haresh Ghatala on 21/01/17.
//  Copyright © 2017 Infosys. All rights reserved.
//

#import "BaseViewController.h"
#import "DataRowTableViewCell.h"
#import "NetworkDataFetcher.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

static NSString *CellIdentifier = @"Table_Cell";

#pragma mark - View Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInitialViews];
    self.title = @"Please Wait...";
    
    [self fetchJsonDataFromNetwork];
    
    // Pull to refresh
    refreshControl = [[UIRefreshControl alloc] init];
    [tblView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - Setup UI

- (void)setupInitialViews
{
    // Initilizing TableView
    tblView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tblView.dataSource = self;
    tblView.delegate = self;
    
    [self.view addSubview:tblView];
    

    // Setting Autolayout Constraints for TableView
    
    [tblView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // Align tblView from the left/right
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tblView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tblView)]];
    
    // Align tblView from the top/bottom
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[tblView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tblView)]];
}

- (void)showActivityOverly {
    
    UIView *overlyView = [[UIView alloc] initWithFrame:self.view.frame];
    overlyView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    progressView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    progressView.center = overlyView.center;
    [progressView startAnimating];
    [overlyView addSubview:progressView];
    
    [self.view addSubview:overlyView];
    [self.view bringSubviewToFront:overlyView];
}

- (void)hideActivityOverly {
    [[progressView superview] removeFromSuperview];
}

- (void)refreshTable {
    [refreshControl endRefreshing];
    [self fetchJsonDataFromNetwork];
}

#pragma mark fetching data

- (void)fetchJsonDataFromNetwork
{
    [self showActivityOverly];
    [NetworkDataFetcher fetchDataRowFromServerWithCompletion:^(NSDictionary *response, NSError *error) {
        if (error) {
            NSLog(@"NetworkDataFetcher Error: %@", error);
        }
        else {
            factData = [[FactDetails alloc] initWithDictionary:response];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // Updateing the UI through main thread
                self.title = factData.strScreenTitle;
                
                [tblView reloadData];
                [self hideActivityOverly];
            });
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return factData.arrFactRows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DataRowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[DataRowTableViewCell alloc] initCellWithReuseIdentifier:CellIdentifier];
    }
    
    RowDetails *row = [factData.arrFactRows objectAtIndex:indexPath.row];
    [cell setValuesToCell:row];
    
    return cell;
}

#pragma mark - Table view delegates

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static DataRowTableViewCell *cell = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        cell = [[DataRowTableViewCell alloc] initCellWithReuseIdentifier:CellIdentifier];
    });
    
    RowDetails *row = [factData.arrFactRows objectAtIndex:indexPath.row];
    [cell setValuesToCell:row];
    
    return [cell getHeightOfCell];
}

@end
