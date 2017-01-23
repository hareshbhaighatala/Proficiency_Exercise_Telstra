//
//  BaseViewController.m
//  Proficiency_Exercise_Telstra
//
//  Created by Haresh Ghatala on 21/01/17.
//  Copyright © 2017 Infosys. All rights reserved.
//

#import "BaseViewController.h"
#import "DataRowTableViewCell.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - View Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInitialViews];
    self.title = @"Please Wait...";
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;//factData.factRows.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Table_Cell";
    DataRowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[DataRowTableViewCell alloc] initCellWithReuseIdentifier:CellIdentifier];
    }
    
    return cell;
    
    
}

#pragma mark - Table view delegates

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

@end
