//
//  Root.m
//  bacsicObjC
//
//  Created by CPU11606 on 8/22/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <ContainerCellBigListDelegate>
@property (nonatomic, strong) NSArray <Content *> *arrContents;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
} 
- (NSArray<Content *> *)arrContents{
    if (!_arrContents){
        _arrContents = [ConnectData connectData].contents;
    }
    return _arrContents;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        [_tableView registerClass:ContainerCell.class forCellReuseIdentifier:@"Containerview"];
        _tableView.delegate = self;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


@end
