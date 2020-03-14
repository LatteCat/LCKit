//
//  LCMultiDelegateViewController.m
//  LCKit_Example
//
//  Created by lattecat on 2020/3/14.
//  Copyright © 2020 lattecat. All rights reserved.
//

#import "LCMultiDelegateViewController.h"
#import "LCMultiDelegateBroadcaster.h"

@interface LCMultiDelegateViewController ()

@property (nonatomic, strong) LCMultiDelegateBroadcaster                  *broadcaster;

@end

@implementation LCMultiDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.broadcaster = [[LCMultiDelegateBroadcaster alloc] init];
    [self.broadcaster addDelegates];
    [self.broadcaster broadcast];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
