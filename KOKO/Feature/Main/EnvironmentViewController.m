//
//  EnvironmentViewController.m
//  KOKO
//
//  Created by Hsieh Min Che on 2019/11/25.
//  Copyright © 2019 Hsieh Min Che. All rights reserved.
//

#import "EnvironmentViewController.h"
#import "Environment.h"

@interface EnvironmentViewController ()

@end

@implementation EnvironmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)apiStateChanged:(UISegmentedControl *)sender {
    [Environment.current setApiState:sender.selectedSegmentIndex];
}

@end
