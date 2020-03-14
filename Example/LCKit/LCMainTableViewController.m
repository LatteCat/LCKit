//
//  LCMainTableViewController.m
//  LCKit_Example
//
//  Created by lattecat on 2020/3/10.
//  Copyright © 2020 lattecat. All rights reserved.
//

#import "LCMainTableViewController.h"
#import "LCThreadExampleViewController.h"
#import "LCWeakProxyViewController.h"
#import "LCMultiDelegateViewController.h"

#define kLCExmapleTitleKey          @"title"
#define kLCExmapleVCCalssKey        @"VC"

@interface LCMainTableViewController ()

@property (nonatomic, strong) NSArray<NSDictionary *>                  *examples;

@end

@implementation LCMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"LCKit Example";
    
    // setup datasources
    self.examples = @[
        @{@"title": @"Thread", @"VC": LCThreadExampleViewController.class},
        @{@"title": @"WeakProxy", @"VC": LCWeakProxyViewController.class},
        @{@"title": @"MultiDelegate", @"VC": LCMultiDelegateViewController.class},
    ];
    
    // setup tableview
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.examples.count;
}


//***********************************************************************************************************************************************************
// MARK:-                                                           Table View Delegate
//***********************************************************************************************************************************************************

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *dict = self.examples[indexPath.row];
    cell.textLabel.text = dict[kLCExmapleTitleKey];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.examples[indexPath.row];
    Class vcClass = dict[kLCExmapleVCCalssKey];
    UIViewController *vc = [[vcClass alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
